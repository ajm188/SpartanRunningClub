class PasswordsController < Clearance::PasswordsController
	def change
		@member = Member.find(params[:id].to_i)
		if current_user.id == @member.id
			@password = Password.new
		else
			redirect_to root_path
		end
	end

	def user_edit
		@member = Member.find(params[:id].to_i)
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

			unless errors.empty?
				render :action => 'change', :locals => { :errors => errors }
			else
				@member.password = new_pass
				unless @member.save
					render :action => 'change'
				else
					MemberMailer.change_password_email(@member).deliver
					redirect_to root_path
				end
			end
		else
			redirect_to root_path
		end
	end
end