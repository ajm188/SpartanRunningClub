class Practice < ActiveRecord::Base

  DAYS = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)

  scope :sunday, -> { where(day: 'Sunday') }
  scope :monday, -> { where(day: 'Monday') }
  scope :tuesday, -> { where(day: 'Tuesday') }
  scope :wednesday, -> { where(day: 'Wednesday') }
  scope :thursday, -> { where(day: 'Thursday') }
  scope :friday, -> { where(day: 'Friday') }
  scope :saturday, -> { where(day: 'Saturday') }
  scope :ordered, -> { order(:date) }

  validates :day, :date,
    presence: true, allow_blanks: false
  validates :day,
    inclusion: { in: DAYS }

  before_save :set_date

  # Convert the practice date to a time string
  def time
    self.date.present? ? self.date.strftime('%I:%M %p') : nil
  end

  private

  # For all we care, the date part of the date field can be 2000-01-01
  # This makes ordering queries better, since all we care about is the time
  # anyway.
  def set_date
    self.date = DateTime.new(2000, 1, 1, self.date.hour, self.date.min)
  end
end
