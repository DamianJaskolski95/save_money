class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :created_by, :cycle_id
  has_many :expenses
end
