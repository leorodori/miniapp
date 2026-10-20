FactoryBot.define do
  factory :note do
    body { Faker::Lorem.sentence(word_count: 10) } 
    association :word
  end
end