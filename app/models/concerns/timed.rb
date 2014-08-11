module Timed
  def time_string
    self.time.present? ? self.time.strftime('%l:%M %p').strip : nil
  end
end