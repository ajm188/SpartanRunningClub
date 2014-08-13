class Following < ActiveRecord::Base
  belongs_to :followable, polymorphic: true
  belongs_to :member

  validates :member_id, :followable_id, :followable_type,
    presence: true, allow_blank: false

  # Lookup and return an instance of a following.
  # Returns nil if the record does not exist
  def self.lookup member_id, followable_id, followable_type
    Following.where(
      member_id: member_id,
      followable_id: followable_id,
      followable_type: followable_type
    ).first
  end
end
