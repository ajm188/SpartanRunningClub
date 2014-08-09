# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :following do
    association :member, factory: :member

    trait :event do
      association :followable, factory: :event
    end
  end
end
