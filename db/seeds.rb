User.create!(login: 'Aga', email: 'aga@email.com', password_digest: BCrypt::Password.create('a1'))

50.times do |i|
  category = Category.create!(name: Faker::Lorem.word + i.to_s, created_by: User.first.id)
  category.expenses.create!(
    expense_day: Faker::Date.between(from: 30.days.ago, to: Date.today),
    value: Faker::Number.decimal(r_digits: 2),
    created_by: User.first.id
  )
end

12.times do |i|
  Balance.create!(
    income: Faker::Number.decimal(r_digits: 2),
    month: i + 1,
    planned_savings: Faker::Number.decimal(r_digits: 2),
    savings: Faker::Number.decimal(r_digits: 2),
    created_by: User.first.id
  )
end

12.times do |i|
  balances = Balance.all
  Cycle.create!(
    planned_value: Faker::Number.decimal(r_digits: 2),
    created_by: User.first.id,
    balance_id: balances[i].id,
    duration: 30,
    start_day: Date.new(Date.today.year, balances[i].month, Date.today.day),
    end_day: Date.new(Date.today.year, balances[i].month, Date.today.day) + 30.days
  )
end
