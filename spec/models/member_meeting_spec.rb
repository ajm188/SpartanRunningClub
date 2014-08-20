require 'rails_helper'

RSpec.describe MemberMeeting, :type => :model do
  it { should validate_presence_of :member_id }
  it { should validate_presence_of :meeting_id }
  it { should validate_presence_of :relationship }

  it { should ensure_inclusion_of(:relationship).in_array(MemberMeeting::RELATIONSHIPS) }

  it { should belong_to :member }
  it { should belong_to :meeting }

  describe 'callbacks' do
    before(:each) do
      @meeting = FactoryGirl.create(:meeting)
      @member = FactoryGirl.create(:member)
      @member_meeting = FactoryGirl.build(:member_meeting, member: @member, meeting: @meeting)
    end

    it "can't create an invitation after meeting date has passed" do
      @meeting.date = Date.today - 1.day
      @meeting.save
      @member_meeting.relationship = MemberMeeting::INVITEE
      expect(@member_meeting.save).to be false
    end

    it "can't destroy an invitation after a meeting date has passed" do
      @member_meeting.relationship = MemberMeeting::INVITEE
      @member_meeting.invitor = FactoryGirl.create(:member)
      @member_meeting.save
      @meeting.date = Date.today - 1.day
      @meeting.save
      expect(@member_meeting.destroy).to be false
    end

    it 'should notify the invitee when an invite is created' do
      @member_meeting.relationship = MemberMeeting::INVITEE
      @member_meeting.invitor = @member
      expect(MeetingMailer).to receive(:invite).and_return(double("Mailer", deliver: true))
      @member_meeting.save
    end
  end
end
