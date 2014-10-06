class ArticleMailer < Mailer
  def notify_update article
    @article = article
    mail(
      to: @article.members.pluck(:email),
      subject: 'An article you are following was recently updated.'
    )
  end  
end