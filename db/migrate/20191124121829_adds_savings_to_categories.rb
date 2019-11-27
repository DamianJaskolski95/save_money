class AddsSavingsToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :category_planned_savings, :decimal
    add_column :cycles, :cycle_value, :decimal
  end
end
