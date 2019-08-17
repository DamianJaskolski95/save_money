class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.integer :month
      t.decimal :planned_value
      t.decimal :value
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
