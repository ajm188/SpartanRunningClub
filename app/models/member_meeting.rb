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

  after_create :notify_member

  private

  def notify_member
    MeetingMailer.invite(self.member, self.meeting, self.invitor).deliver
  end
end
