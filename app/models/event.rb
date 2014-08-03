class Event < ActiveRecord::Base
  include Followable
  
  scope :upcoming, -> { where('time > ?', Time.now) }

  validates :name, :time, :description,
    presence: true, allow_blank: false
end
