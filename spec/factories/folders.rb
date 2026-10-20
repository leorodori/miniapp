FactoryBot.define do
  factory :folder do
    name { Faker::Lorem.word }
    association :user
  end
end