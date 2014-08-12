class MemberMailer < Mailer

  def welcome_email member
    @member = member
    @url = 'running.case.edu'
    mail(
      to: @member.email,
      from: FROM,
      subject: 'Welcome to Spartan Running Club!'
    )
  end

  def change_password_email member
    @member = member
    @url = URL
    mail(
      to: @member.email,
      from: FROM,
      subject: 'Your password has been changed'
    )
  end
end
