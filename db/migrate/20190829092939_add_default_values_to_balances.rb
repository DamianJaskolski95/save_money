class AddDefaultValuesToBalances < ActiveRecord::Migration[5.2]
  def up
    change_column :balances, :planned_savings, :decimal, :default => 0.0
    change_column :balances, :savings, :decimal, :default => 0.0
  end

  def down
    execute 'alter table balances alter column planned_savings drop default'
    execute 'alter table balances alter column savings drop default'
  end
end
