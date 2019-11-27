FactoryBot.define do
  factory :balance do
    income { Faker::Number.decimal(r_digits: 2) }
    balance_date { Faker::Date.between(from: 30.days.ago, to: Date.today) }
    planned_savings { Faker::Number.decimal(r_digits: 2) }
    savings { Faker::Number.decimal(r_digits: 2) }
    created_by { Faker::Number.number }
  end
end
