FactoryBot.define do
  factory :expense do
    month { Faker::Number.within(range: 1..12) }
    planned_value { Faker::Number.decimal(r_digits: 2) }
    value { Faker::Number.decimal(r_digits: 2) }
    category_id { nil }
  end
end
