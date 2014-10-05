class Mailer < ActionMailer::Base
  URL = 'running.case.edu'
  FROM = 'spartan.running.club@gmail.com'
  default from: FROM

  def feedback feedback, member
    @feedback = feedback
    @member = member
    mail(
      to: Member.officers.map { |officer| officer.email },
      subject: "SRC: #{@member.full_name} (#{@member.email}) has some feedback."
    )
  end
end
