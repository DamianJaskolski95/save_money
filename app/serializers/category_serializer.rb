class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :created_by, :cycle
  has_many :expenses
end
