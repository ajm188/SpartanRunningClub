require 'rails_helper'

RSpec.describe Meeting, :type => :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:time) }

  it { should have_many :member_meetings }
  it { should have_many(:invitees).through(:member_meetings) }
  it { should have_many(:attendees).through(:member_meetings) }

  describe '::email_reminder' do
    before(:all) do
      @invitor = FactoryGirl.create(:member)
    end

    context 'with no upcoming meetings' do
      it 'should not call the mailer' do
        expect(MeetingMailer).to_not receive(:remind_invites)
        Meeting.email_reminder
      end
    end

    context 'with a meeting with no invitees' do
      before(:each) do
        FactoryGirl.create(:meeting, date: Date.today + 1.day)
      end

      it 'should not call the mailer' do
        expect(MeetingMailer).to_not receive(:remind_invites)
        Meeting.email_reminder
      end
    end

    context 'with an upcoming meeting with invitees' do
      before(:each) do
        meeting = FactoryGirl.create(:meeting, date: Date.today + 1.day)
        member = FactoryGirl.create(:member)
        create_invite(member, meeting, @invitor)
      end

      it 'should call the mailer' do
        expect(MeetingMailer).to receive(:remind_invitees).and_return(double("Mailer", deliver: true))
        Meeting.email_reminder
      end
    end
  end

  describe '#date_string' do
    before(:all) do
      @meeting = FactoryGirl.build(:meeting)
    end

    context 'when date is set' do
      before(:all) do
        @meeting.date = Date.strptime('12/25/2013', '%m/%d/%Y')
      end

      it 'should return string representing the date' do
        expect(@meeting.date_string).to eq '12/25/2013'
      end
    end

    context 'when date is nil' do
      before(:all) do
        @meeting.date = nil
      end

      it 'should return nil' do
        expect(@meeting.date_string).to be nil
      end
    end
  end

  describe '#time_string' do
    before(:all) do
      @meeting = FactoryGirl.build(:meeting)
    end

    context 'when time is set' do
      before(:all) do
        @meeting.time = Time.strptime('5:30 PM', '%l:%M %p')
      end

      it 'should return string representing the time' do
        expect(@meeting.time_string).to eq '5:30 PM'
      end
    end

    context 'when time is nil' do
      before(:all) do
        @meeting.time = nil
      end

      it 'should return nil' do
        expect(@meeting.time_string).to be nil
      end
    end
  end
end
