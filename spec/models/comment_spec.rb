require 'rails_helper'

RSpec.describe Comment, :type => :model do
  it { should validate_presence_of :comment }
  it { should validate_presence_of :commenter_id }
  it { should validate_presence_of :commentable_id }
  it { should validate_presence_of :commentable_type }

  it { should belong_to :commenter }
  it { should belong_to :commentable }

  describe '::Dated' do
    before(:all) do
      @comment = Comment.new(created_at: DateTime.strptime('08/26/2015', '%m/%d/%Y'))
    end

    it { should respond_to :date_string }

    it 'should use created_at for the date attribute' do
      expect(@comment.date_string).to eq '08/26/2015'
    end
  end

  describe '::Timed' do
    before(:all) do
      @comment = Comment.new(created_at: DateTime.strptime('12:30 PM', '%I:%M %p'))
    end

    it { should respond_to :time_string }

    it 'should use created_at for the time attribute' do
      expect(@comment.time_string).to eq '12:30 PM'
    end
  end
end
