class Event < ActiveRecord::Base
  include Dated
  include Followable
  include Timed
  
  scope :upcoming, -> { where('time >= ?', DateTime.now.beginning_of_day) }

  has_attached_file :photo,
    styles: { thumb: '20x20#', full: '300x200#' },
    default_url: '/images/events/missing_:style.jpg'
  validates_attachment_content_type :photo,
    content_type: /\Aimage/

  validates :name, :time, :date, :description,
    presence: true, allow_blank: false

  # Send an email notifying followers of any upcoming events with 48-hour
  # notice. Run as a cron job.
  def self.notify_followers
    Event.where('date = ?', Date.today + 2.days).each do |event|
      EventMailer.upcoming(event).deliver
    end
  end
end
