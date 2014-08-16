class PasswordsController < Clearance::PasswordsController
  before_filter :authorize_as_officer_or_self, only: [:change, :user_edit]
  before_action :set_member, only: [:change, :user_edit]

  def change
    if current_user.id == @member.id
      @password = Password.new
    else
      redirect_to root_path
    end
  end

  def user_edit
    if current_user.id == @member.id
      old_pass = params[:password][:old_pass]
      new_pass = params[:password][:new_pass]
      confirm_pass = params[:password][:confirm_pass]
      errors = []

      unless BCrypt::Password.new(@member.encrypted_password) == old_pass
        errors << "Old password does not match your password"
      end

      unless new_pass == confirm_pass
        errors << "New passwords do not match"
      end

      if errors.empty?
        @member.password = new_pass
        unless @member.save
          render :action => 'change'
        else
          MemberMailer.change_password_email(@member).deliver
          redirect_to root_path
        end
      else
        render action: 'change', locals: { errors: errors }
      end
    else
      redirect_to root_path
    end
  end

  private

  def set_member
    @member = Member.find(params[:id]) if params[:id]
  end
end
