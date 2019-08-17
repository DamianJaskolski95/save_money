class AddDayYearToExpense < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :day, :integer
    add_column :expenses, :year, :integer
  end
end
