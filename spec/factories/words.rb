FactoryBot.define do
  factory :word do
    name { Faker::Lorem.word } 
    association :user
  end
end