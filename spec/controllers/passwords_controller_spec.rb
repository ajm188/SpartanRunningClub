require 'rails_helper'

RSpec.describe PasswordsController, type: :controller do
  let(:member) { FactoryGirl.create(:member, password: 'password') }
  let(:officer) { FactoryGirl.create(:member, :officer) }

  describe 'GET #change' do
    context 'as guest' do
      before(:each) do
        get :change, id: member.id
      end

      it 'should redirect to sign in' do
        expect(response).to redirect_to sign_in_path
      end
    end

    context 'as officer' do
      before(:each) do
        sign_in_as officer
        get :change, id: member.id
      end

      it 'should render change template' do
        expect(response).to render_template :change
      end

      it 'should set the member' do
        expect(assigns(:member)).to eq member
      end
    end
  end

  describe 'PUT #user_edit' do
    context 'with good params' do
      before(:each) do
        @member = FactoryGirl.create(:member, password: 'password')
        sign_in_as officer
        password_reset = {old_pass: 'password', new_pass: 'Password', confirm_pass: 'Password'}
        put :user_edit, id: @member.id, password_reset: password_reset
      end

      it 'should redirect to root' do
        expect(response).to redirect_to :root
      end

      it 'should flash success' do
        expect(flash[:notice]).to eq 'Password successfully changed.'
      end

      it 'should update the password' do
        expect(BCrypt::Password.new(@member.reload.encrypted_password) == 'Password').to be true
      end
    end

    context 'with bad params' do
      before(:each) do
        sign_in_as officer
        password_reset = {old_pass: 'password', new_pass: nil, confirm_pass: nil}
        put :user_edit, id: member.id, password_reset: password_reset
      end

      it 'should render change template' do
        expect(response).to render_template :change
      end

      it 'should flash an error' do
        expect(flash[:error]).to eq 'An error occurred while changing your password.'
      end
    end

    context 'with incorrect old password' do
      before(:each) do
        sign_in_as officer
        password_reset = {old_pass: 'mumbojumbo'}
        put :user_edit, id: member.id, password_reset: password_reset
      end

      it 'should render template change' do
        expect(response).to render_template :change
      end

      it 'should flash an error' do
        expect(flash[:error]).to eq 'Old password does not match your old password.'
      end
    end

    context "when new password doesn't match confirmation" do
      before(:each) do
        sign_in_as officer
        password_reset = {old_pass: 'password', new_pass: 'hello', confirm_pass: 'world'}
        put :user_edit, id: member.id, password_reset: password_reset
      end

      it 'should render template change' do
        expect(response).to render_template :change
      end

      it 'should flash an error' do
        expect(flash[:error]).to eq 'New passwords do not match.'
      end
    end
  end
end
