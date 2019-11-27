class ChangeMonthIntegerToDate < ActiveRecord::Migration[5.2]
  def up
    remove_column :balances, :month
    add_column :balances, :balance_date, :date
  end

  def down
    add_column :balances, :month, :integer
    remove_column :balances, :balance_date
  end
end
