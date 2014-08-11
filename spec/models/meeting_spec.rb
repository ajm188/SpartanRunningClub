require 'rails_helper'

RSpec.describe Meeting, :type => :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:time) }
end
