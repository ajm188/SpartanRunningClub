class Article < ActiveRecord::Base
  include Commentable
  include Followable
  include Timed

  FOLLOWABLE_TOOLTIP =
    "Follow this article to get email notifications when it is updated."
  
  belongs_to :author, class_name: 'Member'
  belongs_to :editor, class_name: 'Member'

  validates :title, :body, :author_id, :editor_id,
    presence: true, allow_blank: false

  alias_attribute :time, :updated_at

  after_update :notify_followers

  def last_edited_string
    self.time_string +
      (self.author_id != self.editor_id ?
        " (by #{self.editor.full_name})" : "")
  end

  private

  def notify_followers
    ArticleMailer.notify_update(self).deliver
  end
end
