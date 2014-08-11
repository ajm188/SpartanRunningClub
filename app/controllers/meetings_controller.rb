class MeetingsController < ApplicationController
  before_filter :authorize_as_officer
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  # GET /meetings
  def index
    @meetings = Meeting.all
  end

  # GET /meetings/1
  def show
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings
  def create
    @meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        flash[:notice] = 'Meeting was successfully created.'
        format.html { redirect_to edit_meeting_path(@meeting) }
      else
        flash[:error] = 'There were errors when creating this meeting.'
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /meetings/1
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /meetings/1
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def meeting_params
    params.require(:meeting).permit(:title, :date, :time, :minutes)
  end
end
