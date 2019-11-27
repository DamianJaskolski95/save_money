class ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :expense_day, :value, :created_by
end
