class Meeting < ActiveRecord::Base
  validates :title, :date, :time,
    presence: true, allow_blank: false
end
