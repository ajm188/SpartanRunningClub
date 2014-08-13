require 'rails_helper'

RSpec.describe MemberMeeting, :type => :model do
  it { should validate_presence_of :member_id }
  it { should validate_presence_of :meeting_id }
  it { should validate_presence_of :relationship }

  it { should ensure_inclusion_of(:relationship).in_array(MemberMeeting::RELATIONSHIPS) }

  it { should belong_to :member }
  it { should belong_to :meeting }
end
