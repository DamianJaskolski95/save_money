User.create!(
  login: 'Aga',
  email: 'aga@email.com',
  password_digest: BCrypt::Password.create('a1'),
  whole_savings: Faker::Number.number(digits:3)
)

12.times do |i|
  Balance.create!(
    income: Faker::Number.number(digits:3),
    balance_date: Date.new(Date.today.year, i + 1, Date.today.day),
    planned_savings: Faker::Number.number(digits:3),
    savings: Faker::Number.number(digits:3),
    created_by: User.first.id
  )
end

12.times do |i|
  balances = Balance.all
  Cycle.create!(
    planned_value: Faker::Number.number(digits:3),
    cycle_value: Faker::Number.number(digits:3),
    created_by: User.first.id,
    balance_id: balances[i].id,
    duration: 30,
    start_day: Date.new(Date.today.year, balances[i].balance_date.month, Date.today.day),
    end_day: Date.new(Date.today.year, balances[i].balance_date.month, Date.today.day) + 30.days
  )
end

4.times do |i|
  10.times do |j|
    category = Category.create!(
      name: "a" + j.to_s,
      created_by: User.first.id,
      category_savings: Faker::Number.number(digits:2),
      category_planned_savings: Faker::Number.number(digits:3),
      cycle_id: Cycle.find(i + 1).id
    )
    4.times do
      category.expenses.create!(
        expense_day: Faker::Date.between(from: 30.days.ago, to: Date.today),
        value: Faker::Number.number(digits:3),
        created_by: User.first.id
      )
    end
  end
end
