class AddCreatedByToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :created_by, :string
  end
end
