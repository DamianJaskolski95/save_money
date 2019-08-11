FactoryBot.define do
  factory :user do
    login { Faker::Name.name }
    email { 'foo@bar.com' }
    password { 'foobar' }
  end
end
