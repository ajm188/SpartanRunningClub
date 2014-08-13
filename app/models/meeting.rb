class Meeting < ActiveRecord::Base
  include Timed
  include Dated

  has_many :member_meetings
  has_many :invitees, through: :member_meetings,
    class_name: 'Member',
    conditions: "relationship = '#{MemberMeeting::INVITEE}'"
  has_many :attendees, through: :member_meetings,
    class_name: 'Member',
    conditions: "relationship = '#{MemberMeeting::ATTENDEE}'"
  
  validates :title, :date, :time,
    presence: true, allow_blank: false
end
