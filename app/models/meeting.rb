class Meeting < ActiveRecord::Base
  include Timed
  include Dated

  has_many :member_meetings
  has_many :invitees, ->{ where("relationship = ?", MemberMeeting::INVITEE) },
    through: :member_meetings, source: :member
  has_many :attendees, ->{ where("relationship = ?",
    MemberMeeting::ATTENDEE) }, through: :member_meetings, source: :member
  
  validates :title, :date, :time,
    presence: true, allow_blank: false

  # Send an email reminder to all invitees for any meetings occurring tomorrow.
  def self.email_reminder
    Meeting.where(date: Date.today + 1.day).each do |meeting|
      unless meeting.invitees.empty?
        MeetingMailer.remind_invitees(meeting).deliver
      end
    end
  end
end
