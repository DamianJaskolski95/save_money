class BalanceSerializer < ActiveModel::Serializer
  attributes :id, :income, :planned_savings, :month, :savings, :created_by
end
