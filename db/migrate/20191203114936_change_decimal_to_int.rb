class ChangeDecimalToInt < ActiveRecord::Migration[5.2]
  def up
    change_column :balances, :income, :integer, default: "0"
    change_column :balances, :planned_savings, :integer, default: "0"
    change_column :balances, :savings, :integer, default: "0"
    change_column :categories, :category_savings, :integer, default: "0"
    change_column :categories, :category_planned_savings, :integer, default: "0"
    change_column :cycles, :planned_value, :integer, default: "0"
    change_column :cycles, :cycle_value, :integer, default: "0"
    change_column :expenses, :value, :integer, default: "0"
    change_column :users, :whole_savings, :integer, default: "0"
  end

  def down
    change_column :balances, :income, :decimal, default: "0.0"
    change_column :balances, :planned_savings, :decimal, default: "0.0"
    change_column :balances, :savings, :decimal, default: "0.0"
    change_column :categories, :category_savings, :decimal, default: "0.0"
    change_column :categories, :category_planned_savings, :decimal, default: "0.0"
    change_column :cycles, :planned_value, :decimal, default: "0.0"
    change_column :cycles, :cycle_value, :decimal, default: "0.0"
    change_column :expenses, :value, :decimal, default: "0.0"
    change_column :users, :whole_savings, :decimal, default: "0.0"
  end
end
