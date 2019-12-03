FactoryBot.define do
  factory :balance do
    income { Faker::Number.number(digits:3) }
    balance_date { Faker::Date.between(from: 30.days.ago, to: Date.today) }
    planned_savings { Faker::Number.number(digits:3) }
    savings { Faker::Number.number(digits:3) }
    created_by { Faker::Number.number }
  end
end
