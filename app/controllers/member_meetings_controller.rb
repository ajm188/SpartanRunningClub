class MemberMeetingsController < ApplicationController
  before_filter :authorize_as_officer
  before_action :set_member_meeting, only: [:destroy]
  
  def new
    @updates = {
      "#{params[:relationship].downcase}_form" => { partial:
        'member_meetings/new' }
    }
    @relationship = params[:relationship]
    @meeting_id = params[:meeting_id]
    render 'shared/update'
  end

  def create
    @member_meeting = MemberMeeting.new(member_meeting_params)
    @member_meeting.invitor = current_user unless
      @member_meeting.relationship == MemberMeeting::ATTENDEE
    @member_meeting.save
  end

  def destroy
    @member_meeting.destroy
  end

  private

  def set_member_meeting
    @member_meeting = MemberMeeting.where(
      relationship: params[:relationship],
      meeting_id: params[:meeting_id],
      member_id: params[:member_id]
    ).first
  end

  def member_meeting_params
    params.require(:member_meeting)
          .permit(:relationship, :meeting_id, :member_id)
  end
end
