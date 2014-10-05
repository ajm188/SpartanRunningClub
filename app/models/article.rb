class Article < ActiveRecord::Base
  include Followable
  include Timed
  
  belongs_to :author, class_name: 'Member'
  belongs_to :editor, class_name: 'Member'

  validates :title, :body, :author_id, :editor_id,
    presence: true, allow_blank: false

  alias_attribute :time, :updated_at


  def last_edited_string
    self.time_string +
      (self.author_id != self.editor_id ?
        " (by #{self.editor.full_name})" : "")
  end
end
