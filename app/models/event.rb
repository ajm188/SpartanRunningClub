class Event < ActiveRecord::Base
  include Followable
  
  scope :upcoming, -> { where('time >= ?', DateTime.now.beginning_of_day) }

  validates :name, :time, :description,
    presence: true, allow_blank: false
end
