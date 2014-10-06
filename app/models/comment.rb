class Comment < ActiveRecord::Base
  include Dated
  include Timed

  belongs_to :commenter, class_name: 'Member'
  belongs_to :commentable, polymorphic: true

  validates :comment, :commenter_id, :commentable_id, :commentable_type,
    presence: true, allow_blank: false

  alias_attribute :date, :created_at
  alias_attribute :time, :created_at
end
