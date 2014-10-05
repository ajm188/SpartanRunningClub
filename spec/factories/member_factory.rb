FactoryGirl.define do
  factory :member do
    first_name { Forgery::Name.first_name }
    last_name { Forgery::Name.last_name }
    email { Forgery::Email.address }
    sequence :case_id do |n|
      # as long as our tests don't create more the 999 members, we'll be fine
      "abc#{n}"
    end
    year Member::FRESHMAN
    competitive false
    password 'Password'
    officer false

    trait :officer do
      officer true
      position Member::PRESIDENT
    end
  end
end
