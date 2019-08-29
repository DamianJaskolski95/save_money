class BalanceSerializer < ActiveModel::Serializer
  attributes :id, :income, :month, :planned_savings, :savings, :created_by
end
