user = User.create!(login: 'Aga', email: 'aga@email.com', password_digest: BCrypt::Password.create('a1'))

50.times do |i|
  category = Category.create!(name: Faker::Lorem.word + i.to_s, created_by: User.first.id)
  category.expenses.create!(
    expense_day: Faker::Date.between(from: 30.days.ago, to: Date.today),
    planned_value: Faker::Number.decimal(r_digits: 2),
    value: Faker::Number.decimal(r_digits: 2),
    created_by: User.first.id
  )
end

12.times do |i|
  balance = Balance.create!(
    income: Faker::Number.decimal(r_digits: 2),
    month: i + 1,
    planned_savings: Faker::Number.decimal(r_digits: 2),
    savings: Faker::Number.decimal(r_digits: 2),
    created_by: User.first.id
  )
end
