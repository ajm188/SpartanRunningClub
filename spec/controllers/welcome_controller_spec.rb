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

  describe 'GET #feedback' do
    context 'as guest' do
      before(:each) do
        get :feedback
      end

      it 'should redirect to sign in' do
        expect(response).to redirect_to sign_in_path
      end
    end

    context 'as member' do
      before(:each) do
        sign_in_as member
        get :feedback
      end

      it 'should render the feedback template' do
        expect(response).to render_template :feedback
      end
    end
  end

  describe 'POST #submit_feedback' do
    context 'as guest' do
      before(:each) do
        post :submit_feedback
      end

      it 'should redirect to sign in' do
        expect(response).to redirect_to sign_in_path
      end
    end

    context 'as member' do
      before(:each) do
        sign_in_as member
      end

      context 'with empty feedback' do
        before(:each) do
          post :submit_feedback, feedback: ''
        end

        it 'should render the feedback template' do
          expect(response).to render_template :feedback
        end

        it 'should flash an error' do
          expect(flash[:error]).to_not be nil
        end

        it 'should not deliver the feedback' do
          expect(Mailer).to_not receive :feedback
        end
      end

      context 'with actual feedback' do
        before(:all) do
          # Ensure there is an officer to email
          FactoryGirl.create(:member, :officer)
        end

        before(:each) do
          post :submit_feedback, feedback: 'lorem ipsum'
        end

        it 'should redirect to the home page' do
          expect(response).to redirect_to root_path
        end

        it 'should flash success' do
          expect(flash[:notice]).to_not be nil
        end

        it 'should deliver the feedback'
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
