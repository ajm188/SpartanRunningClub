class Event < ActiveRecord::Base
  scope :upcoming, -> { where('time > ?', Time.now) }

  def description_preview
    description[0,50] + "..."
  end
end
