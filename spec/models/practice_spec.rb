require 'rails_helper'

RSpec.describe Practice, type: :model do
  it { should validate_presence_of(:day) }
  it { should validate_presence_of(:date) }

  it { should ensure_inclusion_of(:day).in_array(Practice::DAYS) }

  describe 'callbacks' do
    before(:each) do
      @practice = FactoryGirl.build(:practice)
    end

    it 'should set the date to January 1st 2000' do
      @practice.date = DateTime.new(2001, 4, 3, 3, 30)
      @practice.save
      expect(@practice.date).to eq Time.zone.local(2000, 1, 1, 3, 30)
    end
  end

  describe '#time' do
    before(:all) do
      time = DateTime.strptime('01:15 PM', '%I:%M %p')
      @practice = FactoryGirl.build(:practice, date: time)
    end

    it 'should return a string representing date as a time' do
      expect(@practice.time).to eq '01:15 PM'
    end

    context 'when date is nil' do
      before(:all) do
        @practice.date = nil
      end

      it 'should return nil' do
        expect(@practice.time).to be nil
      end
    end
  end
end
