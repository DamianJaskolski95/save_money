user = User.create!(login: 'Aga', email: 'aga@email.com', password_digest: BCrypt::Password.create('a1'))

50.times do
  category = Category.create(name: Faker::Lorem.word, created_by: User.first.id)
  category.expenses.create(month: Faker::Number.within(range: 1..12),
    planned_value: Faker::Number.decimal(r_digits: 2),
      value: Faker::Number.decimal(r_digits: 2))
end
