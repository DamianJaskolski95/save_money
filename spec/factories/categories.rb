FactoryBot.define do
  factory :category do
    name { Faker::Lorem.word + Faker::Number.number.to_s }
    created_by { Faker::Number.number }
    category_savings { Faker::Number.number(digits:3) }
    category_planned_savings { Faker::Number.number(digits:3) }
    cycle_id { nil }
  end
end
