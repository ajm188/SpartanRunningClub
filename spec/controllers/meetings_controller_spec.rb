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
  end

  describe 'GET #edit' do
  end

  describe 'POST #create' do
  end

  describe 'PATCH #update' do
  end

  describe 'DELETE #destroy' do
  end
end
