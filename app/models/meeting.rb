class Meeting < ActiveRecord::Base
  include Timed
  include Dated
  
  validates :title, :date, :time,
    presence: true, allow_blank: false
end
