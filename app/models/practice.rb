class Practice < ActiveRecord::Base
  include Timed

  DAYS = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)

  scope :sunday, -> { where(day: 'Sunday') }
  scope :monday, -> { where(day: 'Monday') }
  scope :tuesday, -> { where(day: 'Tuesday') }
  scope :wednesday, -> { where(day: 'Wednesday') }
  scope :thursday, -> { where(day: 'Thursday') }
  scope :friday, -> { where(day: 'Friday') }
  scope :saturday, -> { where(day: 'Saturday') }
  scope :ordered, -> { order(:time) }

  validates :day, :time,
    presence: true, allow_blanks: false
  validates :day,
    inclusion: { in: DAYS }
end
