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

  def request_to_officers
    @url = URL
    mail(
      to: Member.officers.map { |o| o.email },
      subject: 'SRC: A member has requested to join.'
    )
  end

  def deny_request email
    @url = URL
    mail(
      to: email,
      subject: 'Your request to join Spartan Running Club was denied.'
    )
  end
end
