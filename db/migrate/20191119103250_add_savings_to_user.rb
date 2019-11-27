class AddSavingsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :whole_savings, :decimal, default: 0.0
  end
end
