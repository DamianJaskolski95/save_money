class Category < ApplicationRecord
  has_many :expenses, dependent: :destroy

  validates_presence_of :name, :created_by
end
