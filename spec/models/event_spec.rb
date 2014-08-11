require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:time) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:description) }

  describe '::Followable' do
    it { should have_many(:followings) }
    it { should have_many(:members) }
  end

  describe '#date_string' do
    before(:all) do
      @event = FactoryGirl.build(:event)
    end

    context 'when date is set' do
      before(:all) do
        @event.date = Date.strptime('12/25/2014', '%m/%d/%Y')
      end

      it 'should return string representing the date' do
        expect(@event.date_string).to eq '12/25/2014'
      end
    end

    context 'when date is nil' do
      before(:all) do
        @event.date = nil
      end

      it 'should return nil' do
        expect(@event.date_string).to be nil
      end
    end
  end

  describe '#time_string' do
    before(:all) do
      @event = FactoryGirl.build(:event)
    end

    context 'when time is set' do
      before(:all) do
        @event.time = Time.strptime('5:30 PM', '%l:%M %p')
      end

      it 'should return string representing the time' do
        expect(@event.time_string).to eq '5:30 PM'
      end
    end

    context 'when time is nil' do
      before(:all) do
        @event.time = nil
      end

      it 'should return nil' do
        expect(@event.time_string).to be nil
      end
    end
  end
end
