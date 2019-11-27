class CreateCycles < ActiveRecord::Migration[5.2]
  def change
    create_table :cycles do |t|
      t.decimal :planned_value
      t.integer :created_by
      t.references :balance

      t.timestamps
    end
  end
end
