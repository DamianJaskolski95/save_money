FactoryBot.define do
  factory :user do
    login { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'foobar' }
  end
end
