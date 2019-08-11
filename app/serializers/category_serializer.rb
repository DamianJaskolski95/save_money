class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :created_by, :created_at, :updated_at
  has_many :expenses
end
