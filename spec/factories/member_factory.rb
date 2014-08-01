FactoryGirl.define do
  factory :member do
    officer false

    trait :officer do
      officer true
    end
  end
end
