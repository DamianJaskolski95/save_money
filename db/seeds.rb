user = User.create!(login: 'Aga', email: 'aga@email.com', password_digest: BCrypt::Password.create('a1'))

50.times do |i|
  category = Category.create!(name: Faker::Lorem.word + i.to_s, created_by: User.first.id)
  category.expenses.create!(
    year: 2019,
    month: Faker::Number.within(range: 1..12),
    day: Faker::Number.within(range: 1..28),
    planned_value: Faker::Number.decimal(r_digits: 2),
    value: Faker::Number.decimal(r_digits: 2),
    created_by: User.first.id
  )
end
