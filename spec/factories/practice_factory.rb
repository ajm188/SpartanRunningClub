FactoryGirl.define do
  factory :practice do
    day 'Sunday'
    time { Time.now }
  end
end
