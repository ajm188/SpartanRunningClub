require 'rails_helper'

RSpec.describe MeetingsController, :type => :controller do
  let(:member) { FactoryGirl.create(:member) }
  let(:officer) { FactoryGirl.create(:member, :officer) }
  let(:meeting) { FactoryGirl.create(:meeting) }

  describe 'GET #index' do
    # Testing authentication is the same for every meetings controller action,
    # so don't bother testing for every action
    context 'as guest' do
      before(:each) do
        get :index
      end

      it 'should redirect to sign in' do
        expect(response).to redirect_to sign_in_path
      end
    end

    context 'as member' do
      before(:each) do
        sign_in_as member
        get :index
      end

      it 'should redirect to root' do
        expect(response).to redirect_to :root
      end
    end

    context 'as officer' do
      before(:each) do
        sign_in_as officer
        get :index
      end

      it 'should render index template' do
        expect(response).to render_template :index
      end

      it 'should assign meetings' do
        expect(assigns(:meetings)).to_not be nil
      end
    end
  end

  describe 'GET #show' do
    before(:each) do
      sign_in_as officer
      get :show, id: meeting.id
    end

    it 'should render show template' do
      expect(response).to render_template :show
    end

    it 'should set the meeting' do
      expect(assigns(:meeting)).to eq meeting
    end
  end

  describe 'GET #new' do
    before(:each) do
      sign_in_as officer
      get :new
    end

    it 'should render new template' do
      expect(response).to render_template :new
    end

    it 'should set the meeting' do
      expect(assigns(:meeting)).to_not be nil
    end
  end

  describe 'GET #edit' do
    before(:each) do
      sign_in_as officer
      get :edit, id: meeting.id
    end

    it 'should render edit template' do
      expect(response).to render_template :edit
    end

    it 'should set the meeting' do
      expect(assigns(:meeting)).to eq meeting
    end
  end

  describe 'POST #create' do
    before(:each) do
      sign_in_as officer
      @count = Meeting.count
    end

    context 'with good params' do
      before(:each) do
        post :create, meeting: {title: 'My meeting', time: Time.now, date: '08/25/14'}
      end

      it 'should create the meeting' do
        expect(Meeting.count).to eq (@count + 1)
      end

      it 'should redirect to edit' do
        expect(response).to redirect_to edit_meeting_path(Meeting.last.id)
      end

      it 'should flash a notice' do
        expect(flash[:notice]).to eq 'Meeting was successfully created.'
      end
    end

    context 'with bad params' do
      before(:each) do
        post :create, meeting: {foo: 'bar'}
      end

      it 'should not create the meeting' do
        expect(Meeting.count).to eq @count
      end

      it 'should render new action' do
        expect(response).to render_template :new
      end

      it 'should flash an error' do
        expect(flash[:error]).to eq 'There were errors when creating this meeting.'
      end
    end
  end

  describe 'PATCH #update' do
    before(:each) do
      sign_in_as officer
    end

    context 'with good params' do
      before(:each) do
        patch :update, id: meeting.id, meeting: {title: 'new title'}
      end

      it 'should update the meeting' do
        expect(meeting.reload.title).to eq 'new title'
      end

      it 'should redirect to edit' do
        expect(response).to redirect_to edit_meeting_path(meeting.id)
      end

      it 'should flash a notice' do
        expect(flash[:notice]).to eq 'Meeting was successfully updated.'
      end
    end

    context 'with bad params' do
      before(:each) do
        patch :update, id: meeting.id, meeting: {foo: 'bar', date: nil}
      end

      it 'should redirect to edit' do
        expect(response).to redirect_to edit_meeting_path(meeting.id)
      end

      it 'should flash an error' do
        expect(flash[:error]).to eq 'There were errors when updating this meeting.'
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      sign_in_as officer
      @meeting = FactoryGirl.create(:meeting)
      @count = Meeting.count
      delete :destroy, id: @meeting.id
    end

    it 'should destroy the meeting' do
      expect(Meeting.count).to eq (@count - 1)
    end

    it 'should redirect to meetings' do
      expect(response).to redirect_to :meetings
    end
  end
end
