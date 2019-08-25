class CreateBalances < ActiveRecord::Migration[5.2]
  def change
    create_table :balances do |t|
      t.decimal :income
      t.integer :month
      t.decimal :planned_savings
      t.decimal :savings
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
