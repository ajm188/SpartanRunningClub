FactoryGirl.define do
  factory :event do
    name { Forgery::LoremIpsum.word }
    description { Forgery::LoremIpsum.words(10) }
    time { DateTime.now + 1.week }
  end
end
