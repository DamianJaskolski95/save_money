FactoryBot.define do
  factory :category do
    name { Faker::Lorem.word + Faker::Number.number.to_s }
    created_by { Faker::Number.number }
  end
end
