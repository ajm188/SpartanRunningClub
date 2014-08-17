FactoryGirl.define do
  factory :meeting do
    title { Forgery::LoremIpsum.words(5) }
    date { Date.today }
    time { Time.now }
  end
end
