require 'rails_helper'

RSpec.describe Following, :type => :model do
  it { should belong_to :followable }
  it { should belong_to :member }
end
