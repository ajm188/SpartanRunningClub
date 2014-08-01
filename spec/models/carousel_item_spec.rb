require 'rails_helper'

RSpec.describe CarouselItem, type: :model do
  it { should validate_presence_of(:place) }

  it { should validate_numericality_of(:place).only_integer.is_greater_than_or_equal_to(0) }

  describe 'paperclip validations' do
    it { should have_attached_file(:image) }
    it { should validate_attachment_presence(:image) }
  end
end
