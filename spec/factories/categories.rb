FactoryBot.define do
  factory :category do
    name { Faker::Lorem.word }
    created_by { Faker::Number.number }
  end
end
