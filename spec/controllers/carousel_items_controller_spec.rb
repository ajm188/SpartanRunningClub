require 'rails_helper'

RSpec.describe CarouselItemsController, type: :controller do
  let(:officer) { FactoryGirl.create(:member, :officer) }

  describe 'GET #new' do
    before(:each) do
      sign_in_as officer
      xhr :get, :new
    end

    it 'should render the update template' do
      expect(response).to render_template 'shared/update'
    end

    it 'should set the carousel_item' do
      expect(assigns(:carousel_item)).to_not be nil
    end

    it 'should set the updates' do
      expect(assigns(:updates)).to_not be nil
    end
  end

  describe 'POST #create' do
    pending
  end

  describe 'GET #edit' do
    pending
  end

  describe 'GET #edit_all' do
    before(:each) do
      sign_in_as officer
    end

    context 'as html' do
      before(:each) do
        get :edit_all
      end

      it 'should render the edit_all template' do
        expect(response).to render_template :edit_all
      end

      it 'should set the items' do
        expect(assigns(:items)).to_not be nil
      end

      it 'should clear the deleted ids from the session' do
        expect(session[:deleted_carousel_ids]).to eq []
      end
    end

    context 'as js' do
      before(:each) do
        xhr :get, :edit_all
      end

      it 'should set the updates'
      it 'should set the items' do
        expect(assigns(:items)).to_not be nil
      end

      it 'should clear the deleted ids from the session' do
        expect(session[:deleted_carousel_ids]).to eq []
      end
    end
  end

  describe 'PUT #update' do
    pending
  end

  describe 'DELETE #destroy' do
    pending
  end

  describe 'PUT #reorder' do
    pending
  end
end
