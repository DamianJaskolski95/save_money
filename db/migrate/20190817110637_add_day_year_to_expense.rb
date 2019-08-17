class AddDayYearToExpense < ActiveRecord::Migration[5.2]
  def up
    add_column :expenses, :day, :integer, :default => 0
    add_column :expenses, :year, :integer, :default => 0
    change_column :expenses, :month, :integer, :default => 0
    change_column :expenses, :planned_value, :decimal, :default => 0.0
    change_column :expenses, :value, :decimal, :default => 0.0
  end

  def down
    remove_column :expenses, :day
    remove_column :expenses, :year
    execute 'alter table expenses alter column month drop default'
    execute 'alter table expenses alter column planned_value drop default'
    execute 'alter table expenses alter column value drop default'
  end
end
