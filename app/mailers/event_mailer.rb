class EventMailer < Mailer
  def upcoming event
    @event = event
    mail(
      to: @event.members.map { |member| member.email },
      from: FROM,
      subject: "Upcoming event: #{@event.name}"
    )
  end
end
