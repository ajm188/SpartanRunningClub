class CarouselItemsController < ApplicationController
  before_filter :authorize_as_officer
  
  before_action :set_carousel_item, only: [:edit, :update, :destroy]

  def new
    @carousel_item = CarouselItem.new
    @updates = {
      'new_carousel_form' => { partial: 'carousel_items/new' }
    }
    render 'shared/update'
  end

  def create
    @carousel_item = CarouselItem.new carousel_item_params.merge({
      place: CarouselItem.count
    })
    respond_to do |format|
      if @carousel_item.save
        format.js { flash[:notice] = 'Carousel Item successfully created.' }
      else
        format.js do
          flash[:error] = 'Carousel Item could not be created.'
          @updates = {
            'new_carousel_form' => { partial: 'carousel_items/new' }
          }
          @extra_js = '$("new_carousel_link").hide();'
          render 'shared/update'
        end
      end
    end
  end

  # Show the edit form for a single carousel item row
  def edit
    respond_to do |format|
      format.js do
        @updates = {
          "carousel_item_#{@carousel_item.id}" =>
            { partial: 'carousel_items/edit' }
        }
        render 'shared/update'
      end
    end
  end

  # Edit the carousel
  def edit_all
    # Either this is initial page load, or the user asked to reset all changes.
    session[:deleted_carousel_ids] = []
    @items = CarouselItem.all
    respond_to do |format|
      format.html
      format.js do
        @updates = {
          'carousel_items' => 'carousel_items/edit_all'
        }
      end
    end
  end

  def update
    if @carousel_item.update carousel_item_params
      redirect_to edit_carousel_path, notice: 'CarouselItem was successfully updated'
    else
      render action: 'edit'
    end
  end

  def destroy
    session[:deleted_carousel_ids] << @carousel_item.id
    flash[:notice] = 'Carousel item marked for deletion. Click "Save All Changes" to complete the transaction.'
    respond_to do |format|
      format.js
    end
  end

  # The jQuery sortable plugin will inject a serialized version of the
  # CarouselItem ordering into the url, like this:
  # => 'carousel_item' => ['1', '4', '3']
  # The array contains the ids of the CarouselItems in their new order.
  # Use this to bulk update the order.
  # Additionally, this action handles any queued deletions stored in the 
  # session.
  def reorder
    actual_ids = CarouselItem.unscoped.map { |item| item.id.to_s }
    concurrent_deletion =
      params[:carousel_item].any? { |id| !actual_ids.include?(id) }
    params[:carousel_item]
      .reject { |id| !actual_ids.include?(id) } if concurrent_deletion
    begin
      CarouselItem.transaction do
        if session[:deleted_carousel_ids].present? &&
          !session[:deleted_carousel_ids].empty?
          delete_condition =
            "id IN (#{session[:deleted_carousel_ids].join(', ')})"
          CarouselItem.connection.execute <<-SQL
            DELETE FROM carousel_items
            WHERE #{delete_condition}
          SQL
        end
        CarouselItem.connection.execute <<-SQL
          UPDATE carousel_items
          SET place = #{build_case_statement(build_order_hash)}
        SQL
        # Clear out the deleted ids stored in the session
        session[:deleted_carousel_ids] = []
        flash[:notice] = 'Carousel was successfully updated.'
        if concurrent_deletion
          flash[:error] = CONCURRENT_DELETE_MESSAGE
          @items = CarouselItem.all
          @updates = {
            'carousel_items' => { partial: 'carousel_items/edit_all' }
          }
        end
      end
    rescue Exception => e
      flash[:error] = 'An error occurred while updating the carousel.'
      flash[:error] << "\n#{e.to_s}"
    end
    respond_to do |format|
      format.js { render 'shared/update' }
    end
  end

  private

  CONCURRENT_DELETE_MESSAGE =
    'Another user may have deleted some carousel items while you were workin' +
      'g. Go yell at them if you really care.'
  
  def set_carousel_item
    @carousel_item = CarouselItem.find params[:id] if params[:id]
  end

  def carousel_item_params
    params.require(:carousel_item).permit(:primary_caption, :secondary_caption,
      :image, :place)
  end

  # Using the serialized ordering from the sortable plugin, build a hash of the
  # form:
  # => {id: new_place}
  def build_order_hash
    order = {}
    params[:carousel_item].each_with_index do |id_string, index|
      order[id_string.to_i] = index
    end
    return order
  end

  # Build a custom case statement based on the ordering
  def build_case_statement order
    sql = "CASE id\n"
    order.each do |id, place|
      sql << "WHEN #{id} THEN #{place}\n"
    end
    sql << "END"
  end
end
