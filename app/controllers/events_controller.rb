class EventsController < ApplicationController
  before_filter :authorize_as_officer, except: [:index, :show]
  
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :parse_date, only: [:create, :update]

  def edit_all
    @events = Event.all
  end

  # GET /events
  def index
    @events = Event.all
  end

  # GET /events/1
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /events/1
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    flash[:notice] = 'Event was successfully destroyed.'
    respond_to do |format|
      format.js
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:name, :date, :time, :description, :photo)
  end

  def parse_date
    return unless params[:event][:date].present?
    params[:event][:date] =
      Date.strptime(params[:event][:date], '%m/%d/%Y')
  end
end
