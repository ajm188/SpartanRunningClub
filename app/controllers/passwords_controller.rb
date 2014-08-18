class PasswordsController < Clearance::PasswordsController
  before_filter :authorize_as_officer_or_self, only: [:change, :user_edit]
  before_action :set_member, only: [:change, :user_edit]

  def change
  end

  def user_edit
    old_pass = params[:password_reset][:old_pass]
    new_pass = params[:password_reset][:new_pass]
    confirm_pass = params[:password_reset][:confirm_pass]

    unless BCrypt::Password.new(@member.encrypted_password) == old_pass
      flash[:error] = 'Old password does not match your old password.'
      render action: 'change' and return
    end

    unless new_pass == confirm_pass
      flash[:error] = 'New passwords do not match.'
      render action: 'change' and return
    end

    @member.password = new_pass
    if @member.save
      flash[:notice] = 'Password successfully changed.'
      redirect_to root_path
    else
      flash[:error] = 'An error occurred while changing your password.'
      render action: 'change'
    end
  end

  private

  def set_member
    @member = Member.find(params[:id]) if params[:id]
  end
end
