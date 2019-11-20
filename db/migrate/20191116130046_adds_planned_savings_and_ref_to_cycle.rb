class AddsPlannedSavingsAndRefToCycle < ActiveRecord::Migration[5.2]
  def up
    add_column :categories, :category_savings, :decimal
    add_reference :categories, :cycles, index: true
  end

  def down
    remove_column :categories, :category_savings
    remove_reference :categories, :cycles
  end
end
