class MemberMeeting < ActiveRecord::Base
  self.table_name = 'members_meetings'

  INVITEE = 'Invitee'
  ATTENDEE = 'Attendee'
  RELATIONSHIPS = [INVITEE, ATTENDEE]

  attr_accessor :invitor # who created the invitation?

  belongs_to :member
  belongs_to :meeting

  validates :member_id, :meeting_id, :relationship,
    presence: true, allow_blank: false
  validates :relationship,
    inclusion: { in: RELATIONSHIPS }

  before_create :check_meeting_date, if: -> { self.relationship == INVITEE }
  after_create :notify_member
  before_destroy :check_meeting_date, if: -> { self.relationship == INVITEE }

  private

  # Cannot create an invitation for a meeting that has already happened
  def check_meeting_date
    return false if self.meeting.date < Date.today
  end

  def notify_member
    MeetingMailer.invite(self.member, self.meeting, self.invitor).deliver
  end
end
