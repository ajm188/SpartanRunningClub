require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  let(:member) { FactoryGirl.create(:member) }
  let(:officer) { FactoryGirl.create(:member, :officer) }

  describe 'GET #autocomplete' do
  end

  describe 'GET #index' do
    before(:each) do
      get :index
    end

    it 'should render index template' do
      expect(response).to render_template :index
    end

    it 'should assign members' do
      expect(assigns(:members)).to_not be nil
    end
  end

  describe 'GET #competitive' do
    context 'as guest' do
      before(:each) do
        get :competitive
      end

      it 'should redirect to sign in' do
        expect(response).to redirect_to sign_in_path
      end
    end

    context 'as member' do
      before(:each) do
        sign_in_as member
        get :competitive
      end

      it 'should render competitive template' do
        expect(response).to render_template :competitive
      end

      it 'should set competitive members' do
        expect(assigns(:competitive_members)).to_not be nil
      end
    end
  end

  describe 'GET #non_competitive' do
    context 'as guest' do
      before(:each) do
        get :non_competitive
      end

      it 'should redirect to sign in' do
        expect(response).to redirect_to sign_in_path
      end
    end

    context 'as member' do
      before(:each) do
        sign_in_as member
        get :non_competitive
      end

      it 'should render non competitive template' do
        expect(response).to render_template :non_competitive
      end

      it 'should set non competitive members' do
        expect(assigns(:non_competitive_members)).to_not be nil
      end
    end
  end

  describe 'GET #officers' do
    before(:each) do
      get :officers
    end

    it 'should render officers template' do
      expect(response).to render_template :officers
    end

    it 'should assign officers' do
      expect(assigns(:officers)).to_not be nil
    end
  end

  describe 'GET #show' do
  end

  describe 'GET #new' do
  end

  describe 'GET #edit' do
    context 'as guest' do
      before(:each) do
        get :edit, id: member.id
      end

      it 'should redirect to sign in' do
        expect(response).to redirect_to sign_in_path
      end
    end

    context 'as member' do
      before(:each) do
        sign_in_as member
      end

      context 'editing other member' do
        before(:each) do
          get :edit, id: officer.id
        end

        it 'should redirect to root' do
          expect(response).to redirect_to :root
        end
      end

      context 'editing self' do
        before(:each) do
          get :edit, id: member.id
        end

        it 'should render edit template'
        it 'should set the member'
      end
    end

    context 'as officer' do
      before(:each) do
        sign_in_as officer
      end

      context 'editing other member' do
        before(:each) do
          get :edit, id: member.id
        end

        it 'should render edit template' do
          expect(response).to render_template :edit
        end

        it 'should set the member' do
          expect(assigns(:member)).to eq member
        end
      end

      context 'editing self' do
        before(:each) do
          get :edit, id: officer.id
        end

        it 'should render edit template' do
          expect(response).to render_template :edit
        end

        it 'should set the member' do
          expect(assigns(:member)).to eq officer
        end
      end
    end
  end

  describe 'GET #edit_all' do
  end

  describe 'POST #create' do
  end

  describe 'PATCH #update' do
  end

  describe 'DELETE #destroy' do
  end
end
