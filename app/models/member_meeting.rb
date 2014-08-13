class MemberMeeting < ActiveRecord::Base
  self.table_name = 'members_meetings'

  INVITEE = 'Invitee'
  ATTENDEE = 'Attendee'
  RELATIONSHIPS = [INVITEE, ATTENDEE]

  belongs_to :member
  belongs_to :meeting

  validates :member_id, :meeting_id, :relationship,
    presence: true, allow_blank: false
  validates :relationship,
    inclusion: { in: RELATIONSHIPS }
end
