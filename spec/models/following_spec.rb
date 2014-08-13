require 'rails_helper'

RSpec.describe Following, :type => :model do
  it { should validate_presence_of :member_id }
  it { should validate_presence_of :followable_id }
  it { should validate_presence_of :followable_type }

  it { should belong_to :followable }
  it { should belong_to :member }

  describe '::lookup' do
    context 'when record exists' do
      before(:all) do
        followable = FactoryGirl.create(:event)
        @following = FactoryGirl.create(:following, followable: followable)
      end

      it 'should return the record' do
        expect(Following.lookup(@following.member_id, @following.followable_id, @following.followable_type)).to eq @following
      end
    end
    context 'when record does not exist' do
      before(:all) do
        @following = Following.new # this can't exist
      end

      it 'should return nil' do
        expect(Following.lookup(@following.member_id, @following.followable_id, @following.followable_type)).to be nil
      end
    end
  end
end
