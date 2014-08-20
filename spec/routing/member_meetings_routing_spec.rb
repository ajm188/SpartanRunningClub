require 'rails_helper'

RSpec.describe MemberMeetingsController, type: :routing do
  describe 'routing' do
    it 'routes to #new as an invite' do
      expect(get: '/member_meetings/new?relationship=Invitee').to route_to('member_meetings#new', relationship: MemberMeeting::INVITEE)
    end

    it 'routes to #new as an attendance' do
      expect(get: '/member_meetings/new?relationship=Attendee').to route_to('member_meetings#new', relationship: MemberMeeting::ATTENDEE)      
    end

    it 'routes to #create' do
      expect(post: '/member_meetings').to route_to 'member_meetings#create'
    end

    it 'routes to #destroy as an invite' do
      expect(delete: '/member_meetings/1?member_id=1&relationship=Invitee').to route_to('member_meetings#destroy', id: "1", member_id: "1", relationship: MemberMeeting::INVITEE)
    end

    it 'routes to #destroy as an attendance' do
      expect(delete: '/member_meetings/1?member_id=1&relationship=Attendee').to route_to('member_meetings#destroy', id: "1", member_id: "1", relationship: MemberMeeting::ATTENDEE)
    end
  end
end
