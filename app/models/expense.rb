class Expense < ApplicationRecord
  include Swagger::Blocks
  belongs_to :category

  validates_presence_of :month
  validates_presence_of :planned_value

  swagger_schema :Expense do
    key :required, [:id, :month, :planned_value]
    property :id do
      key :type, :integer
    end
    property :month do
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
