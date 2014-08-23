require 'rails_helper'

RSpec.describe FollowingsController, type: :controller do
  let(:member) { FactoryGirl.create(:member) }
  let(:event) { FactoryGirl.create(:event) }

  describe 'POST #create' do
    context 'as guest' do
      before(:each) do
        post :create
      end

      it 'should redirect to sign in' do
        expect(response).to redirect_to sign_in_path
      end
    end

    context 'as member' do
      before(:each) do
        sign_in_as member
        @count = Following.count
      end

      context 'with good params' do
        before(:each) do
          xhr :post, :create, following: {member_id: member.id, followable_id: event.id, followable_type: event.class.to_s}
        end

        it 'should create the following' do
          expect(Following.count).to eq (@count + 1)
        end

        it 'should set the updates' do
          expect(assigns(:updates)).to_not be nil
        end

        it 'should flash a notice' do
          expect(flash[:notice]).to eq "You are now following this #{Following.last.followable_type}"
        end

        it 'should render shared update' do
          expect(response).to render_template 'shared/update'
        end
      end

      context 'with bad params' do
        before(:each) do
          xhr :post, :create, following: {followable_id: event.id, followable_type: event.class.to_s}
        end

        it 'should not create the following' do
          expect(Following.count).to eq @count
        end

        it 'should set the updates' do
          expect(assigns(:updates)).to_not be nil
        end

        it 'should flash an error' do
          error = "An error occurred while trying to create a following for this "
          error += event.class.to_s
          expect(flash[:error]).to eq error
        end

        it 'should render shared update' do
          expect(response).to render_template 'shared/update'
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      @following = FactoryGirl.create(:following, member: member, followable: event)
      @count = Following.count
    end

    context 'as guest' do
      before(:each) do
        delete :destroy, id: @following.id
      end

      it 'should redirect to sign in' do
        expect(response).to redirect_to sign_in_path
      end
    end

    context 'as member' do
      before(:each) do
        sign_in_as member
        xhr :delete, :destroy, id: @following.id
      end

      it 'should destroy the following' do
        expect(Following.count).to eq (@count - 1)
      end

      it 'should set the updates' do
        expect(assigns(:updates)).to_not be nil
      end

      it 'should flash a notice' do
        expect(flash[:notice]).to eq "You are no longer following this #{@following.followable_type}"
      end

      it 'should render shared update' do
        expect(response).to render_template 'shared/update'
      end
    end
  end
end
