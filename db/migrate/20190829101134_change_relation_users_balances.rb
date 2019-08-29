class ChangeRelationUsersBalances < ActiveRecord::Migration[5.2]
  def change
    remove_reference :balances, :user, index: true
    add_column :balances, :created_by, :string
  end
end
