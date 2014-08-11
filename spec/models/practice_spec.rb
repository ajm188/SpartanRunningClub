require 'rails_helper'

RSpec.describe Practice, type: :model do
  it { should validate_presence_of(:day) }
  it { should validate_presence_of(:time) }

  it { should ensure_inclusion_of(:day).in_array(Practice::DAYS) }

  describe '#time_string' do
    before(:all) do
      @practice = FactoryGirl.build(:practice)
    end

    context 'when time is set' do
      before(:all) do
        @practice.time = Time.strptime('1:15 PM', '%l:%M %p')
      end

      it 'should return a string representing the time' do
        expect(@practice.time_string).to eq '1:15 PM'
      end
    end

    context 'when time is nil' do
      before(:all) do
        @practice.time = nil
      end

      it 'should return nil' do
        expect(@practice.time_string).to be nil
      end
    end
  end
end
