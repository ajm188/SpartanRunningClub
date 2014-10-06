require 'rails_helper'

RSpec.describe Comment, :type => :model do
  it { should validate_presence_of :comment }
  it { should validate_presence_of :commenter_id }
  it { should validate_presence_of :commentable_id }
  it { should validate_presence_of :commentable_type }

  it { should belong_to :commenter }
  it { should belong_to :commentable }
end
