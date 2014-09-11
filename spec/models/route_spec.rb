require 'rails_helper'

RSpec.describe Route, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :distance }

  it { should validate_numericality_of(:distance).is_greater_than(0) }

  describe 'paperclip validations' do
    it { should have_attached_file :map_image }
    it { should validate_attachment_content_type(:map_image).allowing('image/png', 'image/jpg') }
  end
end
