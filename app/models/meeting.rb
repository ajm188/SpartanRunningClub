class Meeting < ActiveRecord::Base
  validates :title, :date, :time,
    presence: true, allow_blank: false

  def date_string
    self.date.present? ? self.date.strftime('%m/%d/%Y') : nil
  end

  def time_string
    self.time.present? ? self.time.strftime('%l:%M %p').strip : nil
  end
end
