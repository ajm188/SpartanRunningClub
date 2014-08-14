class MeetingMailer < Mailer
  def invite member, meeting, invitor
    @member = member
    @meeting = meeting
    @invitor = invitor
    mail(
      to: @member.email,
      from: FROM,
      subject: "#{@invitor.full_name} has invited you to a meeting."
    )
  end
end