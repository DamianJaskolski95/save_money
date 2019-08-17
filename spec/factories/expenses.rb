FactoryBot.define do
  factory :expense do
    year { Faker::Number.within(range: 2017..2030) }
    month { Faker::Number.within(range: 1..12) }
    day { Faker::Number.within(range: 1..28) }
    planned_value { Faker::Number.decimal(r_digits: 2) }
    value { Faker::Number.decimal(r_digits: 2) }
    category_id { nil }
  end
end
