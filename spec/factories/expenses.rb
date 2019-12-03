FactoryBot.define do
  factory :expense do
    expense_day { Faker::Date.between(from: 30.days.ago, to: Date.today) }
    value { Faker::Number.number(digits:3) }
    created_by { Faker::Number.number }
    category_id { nil }
  end
end
