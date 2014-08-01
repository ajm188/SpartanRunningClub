require 'rails_helper'

RSpec.describe Practice, type: :model do
  it { should validate_presence_of(:day) }
  it { should validate_presence_of(:hour) }
  it { should validate_presence_of(:minute) }
  it { should validate_presence_of(:am_pm) }

  it { should ensure_inclusion_of(:day).in_array(Practice::DAYS) }
  it { should ensure_inclusion_of(:hour).in_array(Practice::HOURS) }
  it { should ensure_inclusion_of(:minute).in_array(Practice::MINUTES) }
  it { should ensure_inclusion_of(:am_pm).in_array(Practice::AMPM) }

  describe '#time' do
    before(:all) do
      @practice = FactoryGirl.build(:practice, hour: 1, minute: 15, am_pm: 'PM')
    end

    it 'should return a string representing the hour, minute and meridian as a time' do
      expect(@practice.time).to eq '1:15 PM'
    end
  end
end
