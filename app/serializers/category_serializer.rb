class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :created_by
  has_many :expenses
end
