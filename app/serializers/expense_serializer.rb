class ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :expense_day, :planned_value, :value, :created_by
end
