# spec/factories/notes.rb
FactoryBot.define do
  factory :note do
    body { "テスト用のメモ本文です。" }
    association :word
  end
end