class Expense < ApplicationRecord
  belongs_to :category

  validates_presence_of :month
  validates_presence_of :planned_value
end
