class ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :month, :planned_value, :value
end
