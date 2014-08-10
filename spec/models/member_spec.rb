require 'rails_helper'

RSpec.describe Member, type: :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:case_id) }
  it { should validate_presence_of(:year) }
  it { should validate_presence_of(:password) }

  it { should allow_value('def123', 'def13').for(:case_id) }
  it { should_not allow_value('123abc', 'abc', '123', '').for(:case_id) }

  it { should ensure_inclusion_of(:year).in_array(Member::YEARS) }

  it { should ensure_length_of(:case_id).is_at_most(6) }

  context 'as an officer' do
    subject { FactoryGirl.build(:member, :officer) }

    it { should validate_presence_of(:position) }

    it { should ensure_inclusion_of(:position).in_array(Member::OFFICER_POSITIONS)}
  end

  describe 'custom validations' do
    before(:each) do
      @member = FactoryGirl.build(:member)
    end

    context 'with no email' do
      before(:each) do
        @member.email = nil
      end

      it 'should set email based on case id' do
        @member.valid?
        expect(@member.email).to eq "#{@member.case_id}@case.edu"
      end
    end
  end

  it { should have_many(:followings) }
  it { should have_many(:followables).through(:followings) }
  it { should have_many(:events).through(:followings) }

  describe '#full_name' do
    before(:all) do
      @member = FactoryGirl.build(:member)
      @member.first_name = 'hello'
      @member.last_name = 'world'
    end

    it 'should concatenate first and last name' do
      expect(@member.full_name).to eq "hello world"
    end
  end

  describe '#follows?' do
    context 'when member follows' do
      before(:all) do
        @followable = FactoryGirl.create(:event)
        @member = FactoryGirl.create(:member)
        FactoryGirl.create(:following, member: @member, followable: @followable)
      end

      it 'should return an object' do
        expect(@member.follows?(@followable)).to_not be nil
      end
    end

    context 'when member does not follow' do
      before(:all) do
        @followable = FactoryGirl.create(:event)
        @member = FactoryGirl.create(:member)
      end

      it 'should return nil' do
        expect(@member.follows?(@followable)).to be nil
      end
    end
  end
end
