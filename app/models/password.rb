class Password
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  
  attr_accessor :old_pass, :new_pass, :confirm_pass

  def initialize o = nil, n = nil, c = nil
    @old_pass = o
    @new_pass = n
    @confirm_pass = c
  end
end