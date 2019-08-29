class Balance < ApplicationRecord
  belongs_to :user
  validates :income, :planned_savings, :numericality => { greater_than_or_equal_to: 0 }
  validates :month, :numericality => { greater_than: 0, less_than: 13, only_integer: true }
end
