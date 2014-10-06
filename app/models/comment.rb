class Comment < ActiveRecord::Base
  belongs_to :commenter, class_name: 'Member'
  belongs_to :commentable, polymorphic: true

  validates :comment, :commenter_id, :commentable_id, :commentable_type,
    presence: true, allow_blank: false
end
