require 'rails_helper'

RSpec.describe Article, :type => :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:author_id) }
  it { should validate_presence_of(:editor_id) }

  it { should belong_to(:author) }
  it { should belong_to(:editor) }

  describe '::Followable' do
    it { should have_many(:followings) }
    it { should have_many(:members) }
  end

  describe '::Commentable' do
    it { should have_many :comments }
  end
end
