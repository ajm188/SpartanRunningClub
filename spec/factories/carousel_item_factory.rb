include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :carousel_item do
    place { CarouselItem.count }
    image { fixture_file_upload(Rails.root.join('public', 'images', 'members', 'missing_thumb.jpg')) }
  end
end
