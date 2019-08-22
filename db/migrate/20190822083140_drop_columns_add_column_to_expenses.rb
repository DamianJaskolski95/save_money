class DropColumnsAddColumnToExpenses < ActiveRecord::Migration[5.2]
  def change
    remove_column :expenses, :year
    remove_column :expenses, :month
    remove_column :expenses, :day
    
    add_column :expenses, :expense_day, :date
  end
end
