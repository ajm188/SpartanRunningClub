module Dated
  def date_string
    self.date.present? ? self.date.strftime('%m/%d/%Y') : nil
  end
end