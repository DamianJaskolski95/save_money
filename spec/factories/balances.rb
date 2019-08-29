FactoryBot.define do
  factory :balance do
    income { Faker::Number.decimal(r_digits: 2) }
    month { Faker::Number.between(from: 1, to: 12) }
    planned_savings { Faker::Number.decimal(r_digits: 2) }
    savings { Faker::Number.decimal(r_digits: 2) }
  end
end
