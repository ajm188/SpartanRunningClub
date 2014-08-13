class Meeting < ActiveRecord::Base
  include Timed
  include Dated

  has_many :member_meetings
  has_many :invitees, ->{ where relationship: MemberMeeting::INVITEE },
    through: :member_meetings, class_name: 'Member'
  has_many :attendees, ->{ where relationship: MemberMeeting::ATTENDEE },
    through: :member_meetings, class_name: 'Member'
  
  validates :title, :date, :time,
    presence: true, allow_blank: false
end
