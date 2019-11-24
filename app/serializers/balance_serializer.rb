class BalanceSerializer < ActiveModel::Serializer
  attributes :id, :income, :planned_savings, :balance_date, :savings, :created_by
end
