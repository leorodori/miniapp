FactoryBot.define do
  factory :word do
    sequence(:name) { |n| "単語#{n}" }
    association :user
  end
end