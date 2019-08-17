class ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :year, :month, :day, :planned_value, :value
end
