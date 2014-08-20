require 'rails_helper'

RSpec.describe MemberMeetingsController, type: :routing do
  describe 'routing' do
    it 'routes to #new as an invite' do
      expect(get: '/member_meetings/new?relationship=Invitee').to route_to('member_meetings#new', relationship: MemberMeeting::INVITEE)
    end

    it 'routes to #new as an attendance' do
      expect(get: '/member_meetings/new?relationship=Attendee').to route_to('member_meetings#new', relationship: MemberMeeting::ATTENDEE)      
    end
  end
end
