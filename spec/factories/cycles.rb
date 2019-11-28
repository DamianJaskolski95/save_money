FactoryBot.define do
  factory :cycle do
    created_by { nil }
    balance_id { nil }
    planned_value { Faker::Number.decimal(r_digits: 2) }
    cycle_value { Faker::Number.decimal(r_digits: 2) }
    start_day { Date.today }
    end_day { Date.today + 30.days }
  end
end
