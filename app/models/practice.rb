class Practice < ActiveRecord::Base
	validates :day, :hour, :minute, :am_pm, presence: true, allow_blanks: false

	scope :sunday, -> { where(day: 'Sunday') }
	scope :monday, -> { where(day: 'Monday') }
	scope :tuesday, -> { where(day: 'Tuesday') }
	scope :wednesday, -> { where(day: 'Wednesday') }
	scope :thursday, -> { where(day: 'Thursday') }
	scope :friday, -> { where(day: 'Friday') }
	scope :saturday, -> { where(day: 'Saturday') }
	scope :morning, -> { where(am_pm: 'AM') }
	scope :afternoon, -> { where(am_pm: 'PM') }
	scope :ordered, -> { order(:am_pm, :hour, :minute) }

	DAYS = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
	HOURS = %w(1 2 3 4 5 6 7 8 9 10 11 12)
	MINUTES = %w(00 15 30 45)
	AMPM = %w(AM PM)

	def time
		"#{hour}:#{minute} #{am_pm}"
	end
end
