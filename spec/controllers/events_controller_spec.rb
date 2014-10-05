require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:member) { FactoryGirl.create(:member) }
  let(:officer) { FactoryGirl.create(:member, :officer) }
  let(:event) { FactoryGirl.create(:event) }

  describe 'GET #edit_all' do
    context 'as guest' do
      before(:each) do
        get :edit_all
      end

      it 'should redirect to sign in' do
        expect(response).to redirect_to sign_in_path
      end
    end

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

      it 'should set events' do
        expect(assigns(:events)).to_not be nil
      end
    end
  end

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

      it 'should set events' do
        expect(assigns(:events)).to_not be nil
      end
    end
  end

  describe 'GET #show' do
    before(:each) do
      sign_in_as member
      get :show, id: event.id
    end

    it 'should render show template' do
      expect(response).to render_template :show
    end

    it 'should set the event' do
      expect(assigns(:event)).to eq event
    end
  end

  describe 'GET #new' do
    before(:each) do
      sign_in_as officer
      get :new
    end

    it 'should render new template' do
      expect(response).to render_template :new
      expect(assigns(:event)).to_not be nil
    end
  end

  describe 'GET #edit' do
    before(:each) do
      sign_in_as officer
      get :edit, id: event.id
    end

    it 'should render edit template' do
      expect(response).to render_template :edit
    end

    it 'should set the event' do
      expect(assigns(:event)).to eq event
    end
  end

  describe 'POST #create' do
    before(:each) do
      sign_in_as officer
      @count = Event.count
    end

    context 'with good params' do
      before(:each) do
        event_params = FactoryGirl.attributes_for(:event)
        event_params[:date] = '08/23/14'
        post :create, event: event_params
      end

      it 'should create the event' do
        expect(Event.count).to eq (@count + 1)
      end

      it 'should redirect to show' do
        expect(response).to redirect_to event_path(Event.last.id)
      end
    end

    context 'with bad params' do
      before(:each) do
        post :create, event: {foo: 'bar'}
      end

      it 'should not create the event' do
        expect(Event.count).to eq @count
      end

      it 'should render action new' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before(:each) do
      sign_in_as officer
    end

    context 'with good params' do
      before(:each) do
        patch :update, id: event.id, event: {name: 'new name'}
      end

      it 'should update the event' do
        expect(event.reload.name).to eq 'new name'
      end

      it 'should redirect to show' do
        expect(response).to redirect_to event_path(event.id)
      end
    end

    context 'with bad params' do
      before(:each) do
        patch :update, id: event.id, event: {name: nil}
      end

      it 'should not update the event' do
        expect(event.reload.name).to_not be nil
      end

      it 'should render edit action' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      sign_in_as officer
      @event = FactoryGirl.create(:event)
      @count = Event.count
      xhr :delete, :destroy, id: @event.id
    end

    it 'should destroy the event' do
      expect(Event.count).to eq (@count - 1)
    end

    it 'should render the destroy template' do
      expect(response).to render_template :destroy
    end
  end
end
