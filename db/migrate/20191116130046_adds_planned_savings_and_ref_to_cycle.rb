class AddsPlannedSavingsAndRefToCycle < ActiveRecord::Migration[5.2]
  def up
    add_column :categories, :category_savings, :decimal
    add_reference :categories, :cycle, index: true
  end

  def down
    remove_column :categories, :category_savings
    remove_reference :categories, :cycle
  end
end
