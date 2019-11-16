class AddsStartEndDateToCycle < ActiveRecord::Migration[5.2]
  def change
    add_column :cycles, :start_day, :date
    add_column :cycles, :end_day, :date
    add_column :cycles, :duration, :integer, default: 30
  end
end
