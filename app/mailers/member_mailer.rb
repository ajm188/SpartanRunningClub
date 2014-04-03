class MemberMailer < ActionMailer::Base
	default from: "running-club@case.edu"

	def welcome_email member
		@member = member
		@url = 'running.case.edu'
		mail(to: @member.email, from: 'running-club@case.edu', subject: 'Welcome to Spartan Running Club!')
	end

	def change_password_email member
		@member = member
		@url = 'running.case.edu'
		mail(:to => @member.email, :from => 'running-club@case.edu', :subject => 'Your password has been changed')
	end
end
