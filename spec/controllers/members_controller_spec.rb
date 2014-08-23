require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  let(:member) { FactoryGirl.create(:member) }
  let(:officer) { FactoryGirl.create(:member, :officer) }

  describe 'GET #autocomplete' do
    before(:each) do
      get :autocomplete, term: member.case_id
    end

    it 'should be successful' do
      expect(response.response_code).to eq 200
    end
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
    before(:each) do
      sign_in_as member
      get :show, id: member.id
    end

    it 'should render show template' do
      expect(response).to render_template :show
    end

    it 'should set the member' do
      expect(assigns(:member)).to eq member
    end
  end

  describe 'GET #new' do
    context 'as member' do
      before(:each) do
        sign_in_as member
        get :new
      end

      it 'should redirect to root' do
        expect(response).to redirect_to :root
      end
    end

    context 'as officer' do
      before(:each) do
        sign_in_as officer
        get :new
      end

      it 'should render new template' do
        expect(response).to render_template :new
      end

      it 'should set the member' do
        expect(assigns(:member)).to_not be nil
      end
    end
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
    context 'as member' do
      before(:each) do
        sign_in_as member
        get :edit_all
      end

      it 'should redirect to root' do
        expect(response).to redirect_to :root
      end
    end

    context 'as officer' do
      before(:each) do
        sign_in_as officer
        get :edit_all
      end

      it 'should render the edit_all template' do
        expect(response).to render_template :edit_all
      end

      it 'should set the members' do
        expect(assigns(:members)).to_not be nil
      end
    end
  end

  describe 'POST #create' do
    context 'as member' do
      before(:each) do
        sign_in_as member
        post :create
      end

      it 'should redirect to root' do
        expect(response).to redirect_to :root
      end
    end

    context 'as officer' do
      before(:each) do
        sign_in_as officer
      end

      context 'with good params' do
        before(:each) do
          @count = Member.count
          post :create, member: FactoryGirl.attributes_for(:member)
        end

        it 'should create the member' do
          expect(Member.count).to eq (@count + 1)
        end
      end

      context 'with bad params' do
        before(:each) do
          post :create, member: {first_name: 'Hello'}
        end

        it 'should rerender the new action' do
          expect(MemberMailer).to_not receive(:welcome_email)
          expect(response).to render_template :new
        end
      end
    end
  end

  describe 'PATCH #update' do
    context 'with good params' do
      before(:each) do
        sign_in_as officer
        put :update, id: officer.id, member: {first_name: 'hello'}
      end

      it 'should update the member' do
        expect(officer.reload.first_name).to eq 'hello'
      end

      it 'should redirect to show' do
        expect(response).to redirect_to member_path(officer.id)
      end
    end

    context 'with params that break validation' do
      before(:each) do
        sign_in_as officer
        put :update, id: officer.id, member: {case_id: nil}
      end

      it 'should render edit template' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'as member' do
      context 'deleting other member' do
        before(:each) do
          sign_in_as member
          delete :destroy, id: officer.id
        end

        it 'should redirect to root' do
          expect(response).to redirect_to :root
        end
      end

      context 'deleting self' do
        before(:each) do
          @member = FactoryGirl.create(:member)
          sign_in_as @member
          delete :destroy, id: @member.id
        end

        it 'should destroy the member'
      end
    end

    context 'as officer' do
      context 'deleting other member' do
        before(:each) do
          @officer = FactoryGirl.create(:member, :officer)
          @member = FactoryGirl.create(:member)
          sign_in_as @officer
          delete :destroy, id: @member.id
        end

        it 'should destroy the member' do
          expect(Member.exists?(@member.id)).to be nil
          expect(response).to redirect_to :edit_members
        end
      end

      context 'deleting self' do
        before(:each) do
          @officer = FactoryGirl.create(:member, :officer)
          sign_in_as @officer
          delete :destroy, id: @officer.id
        end

        it 'should destroy the member' do
          expect(Member.exists?(@officer.id)).to be nil
        end
      end
    end
  end
end
