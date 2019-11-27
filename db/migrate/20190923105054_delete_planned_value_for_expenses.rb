class DeletePlannedValueForExpenses < ActiveRecord::Migration[5.2]
  def change
    remove_column :expenses, :planned_value
  end
end
