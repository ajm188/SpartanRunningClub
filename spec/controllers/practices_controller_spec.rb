require 'rails_helper'

RSpec.describe PracticesController, type: :controller do
  let(:member) { FactoryGirl.create(:member) }
  let(:officer) { FactoryGirl.create(:member, :officer) }

  describe 'GET #index' do
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

      it 'should render index template' do
        expect(response).to render_template :index
      end

      it 'should set weekday variables' do
        expect_weekdays_set
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

      it 'should render edit_all template' do
        expect(response).to render_template :edit_all
      end

      it 'should set the practices' do
        expect(assigns(:practices)).to_not be nil
      end
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

      it 'should set the practice' do
        expect(assigns(:practice)).to_not be nil
      end
    end
  end

  describe 'POST #create' do
    before(:each) do
      sign_in_as officer
      @count = Practice.count
    end

    context 'with good params' do
      before(:each) do
        post :create, practice: FactoryGirl.attributes_for(:practice)
      end

      it 'should create a practice' do
        expect(Practice.count).to eq (@count + 1)
      end

      it 'should redirect to edit practices' do
        expect(response).to redirect_to edit_practices_path
      end
    end

    context 'with bad params' do
      before(:each) do
        post :create, practice: {foo: 'bar'}
      end

      it 'should not create practice' do
        expect(Practice.count).to eq @count
      end

      it 'should render new action' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      sign_in_as officer
      practice = FactoryGirl.create(:practice)
      @count = Practice.count
      delete :destroy, id: practice.id
    end

    it 'should destroy the practice' do
      expect(Practice.count).to eq (@count - 1)
    end

    it 'should redirect to edit practices' do
      expect(response).to redirect_to edit_practices_path
    end
  end
end

def expect_weekdays_set
  [:sundays, :mondays, :tuesdays, :wednesdays, :thursdays, :fridays, :saturdays].each do |weekday|
    expect(assigns(weekday)).to_not be nil
  end
end
