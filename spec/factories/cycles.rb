FactoryBot.define do
  factory :cycle do
    created_by { nil }
    balance_id { nil }
    planned_value { Faker::Number.number(digits:3) }
    cycle_value { Faker::Number.number(digits:3) }
    start_day { Date.today }
    end_day { Date.today + 30.days }
  end
end
