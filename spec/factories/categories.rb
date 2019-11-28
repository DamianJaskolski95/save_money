FactoryBot.define do
  factory :category do
    name { Faker::Lorem.word + Faker::Number.number.to_s }
    created_by { Faker::Number.number }
    category_savings { Faker::Number.decimal(r_digits: 2) }
    category_planned_savings { Faker::Number.decimal(r_digits: 2) }
    cycle_id { nil }
  end
end
