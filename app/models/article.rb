class Article < ActiveRecord::Base
  include Followable
  
  belongs_to :author, class_name: 'Member'
  belongs_to :editor, class_name: 'Member'

  validates :title, :body, :author_id, :editor_id,
    presence: true, allow_blank: false
end
