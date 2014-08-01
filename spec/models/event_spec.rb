require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:time) }
  it { should validate_presence_of(:description) }
end
