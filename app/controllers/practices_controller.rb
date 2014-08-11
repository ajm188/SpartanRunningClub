class PracticesController < ApplicationController
  before_filter :authorize_as_officer, except: [:index]

  before_action :set_practice, only: [:destroy]

  def index
    @sundays = Practice.sunday.ordered
    @mondays = Practice.monday.ordered
    @tuesdays = Practice.tuesday.ordered
    @wednesdays = Practice.wednesday.ordered
    @thursdays = Practice.thursday.ordered
    @fridays = Practice.friday.ordered
    @saturdays = Practice.saturday.ordered
  end

  def edit_all
    @practices = Practice.sunday.ordered
    @practices = @practices.concat Practice.monday.ordered
    @practices = @practices.concat Practice.tuesday.ordered
    @practices = @practices.concat Practice.wednesday.ordered
    @practices = @practices.concat Practice.thursday.ordered
    @practices = @practices.concat Practice.friday.ordered
    @practices = @practices.concat Practice.saturday.ordered
  end

  def new
    @practice = Practice.new
  end

  def create
    @practice = Practice.new practice_params
    if @practice.save
      redirect_to edit_practices_path
    else
      render action: 'new'
    end
  end

  def destroy
    @practice.destroy
    redirect_to edit_practices_path
  end

  private
  def practice_params
    params.require(:practice).permit(:day, :time)
  end

  def set_practice
    @practice = Practice.find params[:id] if params[:id]
  end
end
