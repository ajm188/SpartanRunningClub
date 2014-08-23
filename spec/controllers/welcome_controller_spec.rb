require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  let(:member) { FactoryGirl.create(:member) }

  describe 'GET #home' do
    before(:each) do
      get :home
    end

    it 'should render home template' do
      expect(response).to render_template :home
    end

    it 'should get first carousel item' do
      expect(assigns(:active)).to_not be nil
    end

    it 'should get remaining carousel items' do
      expect(assigns(:items)).to_not be nil
    end

    it 'should get upcoming events' do
      expect(assigns(:upcoming_events)).to_not be nil
    end
  end

  describe 'GET #contact' do
    before(:each) do
      get :contact
    end

    it 'should render contact template' do
      expect(response).to render_template :contact
    end

    it 'should get the officers' do
      expect(assigns(:officers)).to_not be nil
    end
  end

  describe 'GET #about' do
    before(:each) do
      get :about
    end

    it 'should render about template' do
      expect(response).to render_template :about
    end
  end

  describe 'GET #log_a_run' do
    context 'with no user signed in' do
      before(:each) do
        get :log_a_run
      end

      it 'should redirect to sign in' do
        expect(response).to redirect_to sign_in_path
      end
    end

    context 'with a user' do
      before(:each) do
        sign_in_as member
        get :log_a_run
      end

      it 'should render log_a_run template' do
        expect(response).to render_template :log_a_run
      end
    end
  end

  describe 'GET #spartan_link' do
    context 'with no user signed in' do
      before(:each) do
        get :spartan_link
      end

      it 'should redirect to sign in' do
        expect(response).to redirect_to sign_in_path
      end
    end

    context 'with a user' do
      before(:each) do
        sign_in_as member
        get :spartan_link
      end

      it 'should render spartan_link template' do
        expect(response).to render_template :spartan_link
      end
    end
  end
end
