class Event < ActiveRecord::Base
  include Dated
  include Followable
  include Timed
  
  scope :upcoming, -> { where('time >= ?', DateTime.now.beginning_of_day) }

  validates :name, :time, :date, :description,
    presence: true, allow_blank: false
end
