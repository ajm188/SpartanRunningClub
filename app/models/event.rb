class Event < ActiveRecord::Base
  def description_preview
    description[0,50] + "..."
  end
end
