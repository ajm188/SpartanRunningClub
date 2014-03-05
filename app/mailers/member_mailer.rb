class MemberMailer < ActionMailer::Base
  default from: "src@case.edu"

  def welcome_email member
  	@member = member
  	@url = 'running.case.edu'
  	mail(to: @member.email, subject: 'Welcome to Spartan Running Club!')
  end
end
