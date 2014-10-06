class Comment < ActiveRecord::Base
  belongs_to :commenter, class_name: 'Member'
  belongs_to :commentable, polymorphic: true
end
