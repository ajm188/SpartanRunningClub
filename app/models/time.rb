require 'time'

class Time
  DAY_NAMES = %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
  MONTH_NAMES = %w(January February March April May June July August September October November December)

  # to_s for the Time object, but in a pretty format
  def pretty
    "#{day_name} #{month_name} #{day}, #{year} at #{std_hour}:#{std_min} #{time_mod}"
  end

  # returns the day of the week for this Time as a string
  def day_name
    DAY_NAMES[wday]
  end

  # returns the name of the month for this Time
  def month_name
    MONTH_NAMES[month - 1]
  end

  # returns the hour in 12-hour time
  def std_hour
    h = hour % 12
    h == 0 ? h + 12 : h
  end

  # pads the minute with an extra zero if necessary
  def std_min
    min < 10 ? "0#{min}" : "#{min}"
  end

  # returns AM or PM for this Time
  def time_mod
    hour < 12 ? 'AM' : 'PM'
  end
end