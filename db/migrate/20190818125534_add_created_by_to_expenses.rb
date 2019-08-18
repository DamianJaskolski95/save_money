class AddCreatedByToExpenses < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :created_by, :integer
  end
end
