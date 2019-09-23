FactoryBot.define do
  factory :expense do
    expense_day { Faker::Date.between(from: 30.days.ago, to: Date.today) }
    value { Faker::Number.decimal(r_digits: 2) }
    created_by { Faker::Number.number }
    category_id { nil }
  end
end
