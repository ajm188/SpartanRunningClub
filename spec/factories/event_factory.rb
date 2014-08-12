FactoryGirl.define do
  factory :event do
    name { Forgery::LoremIpsum.word }
    description { Forgery::LoremIpsum.words(10) }
    date { Date.today + 1.week }
    time { Time.now }
  end
end
