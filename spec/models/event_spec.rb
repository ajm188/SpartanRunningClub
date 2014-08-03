require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:time) }
  it { should validate_presence_of(:description) }

  describe '::Followable' do
    it { should have_many(:followings) }
    it { should have_many(:members) }
  end
end
