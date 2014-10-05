require 'rails_helper'

RSpec.describe MemberMeetingsController, type: :controller do
  let(:member) { FactoryGirl.create(:member) }
  let(:officer) { FactoryGirl.create(:member, :officer) }
  let(:meeting) { FactoryGirl.create(:meeting, date: Date.today + 1.day) }

  describe 'GET #new' do
    context 'as guest' do
      before(:each) do
        get :new
      end

      it 'should redirect to sign in' do
        expect(response).to redirect_to sign_in_path
      end
    end

    context 'as member' do
      before(:each) do
        sign_in_as member
        get :new
      end

      it 'shoud redirect_to root' do
        expect(response).to redirect_to :root
      end
    end

    context 'as officer' do
      before(:each) do
        sign_in_as officer
        xhr :get, :new, relationship: MemberMeeting::INVITEE, meeting_id: meeting.id
      end

      it 'should render shared update' do
        expect(response).to render_template 'shared/update'
      end

      it 'should set updates' do
        expect(assigns(:updates)).to_not be nil
      end

      it 'should set the relationship' do
        expect(assigns(:relationship)).to eq MemberMeeting::INVITEE
      end

      it 'should set the meeting id' do
        expect(assigns(:meeting_id)).to eq meeting.id.to_s
      end
    end
  end

  describe 'POST #create' do
    before(:each) do
      sign_in_as officer
      xhr :post, :create, member_meeting: {relationship: MemberMeeting::INVITEE, meeting_id: meeting.id, member_id: officer.id}
    end

    it 'should create the meeting' do
      expect(response).to render_template :create
      expect(assigns(:member_meeting)).to eq MemberMeeting.where(meeting_id: meeting.id, member_id: officer.id, relationship: MemberMeeting::INVITEE).first
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      MemberMeeting.create({
        relationship: MemberMeeting::ATTENDEE,
        member_id: officer.id,
        meeting_id: meeting.id
      })
      sign_in_as officer
      xhr :delete, :destroy, id: 1, relationship: MemberMeeting::ATTENDEE, member_id: officer.id, meeting_id: meeting.id
    end

    it 'should destroy the member meeting' do
      expect(response).to render_template :destroy
      expect(MemberMeeting.where(meeting_id: meeting.id, member_id: officer.id, relationship: MemberMeeting::ATTENDEE).first).to be nil
    end
  end
end
