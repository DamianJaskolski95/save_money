class Expense < ApplicationRecord
  include Swagger::Blocks
  belongs_to :category

  swagger_schema :Expense do
    key :required, [:id, :planned_value]
    property :id do
      key :type, :integer
    end
    property :year do
      key :type, :integer
    end
    property :month do
      key :type, :integer
    end
    property :day do
      key :type, :integer
    end
    property :planned_value do
      key :type, :number
      key :format, :double
    end
    property :value do
      key :type, :number
      key :format, :double
    end
  end
end
