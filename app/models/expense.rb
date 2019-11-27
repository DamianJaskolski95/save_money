class Expense < ApplicationRecord
  include Swagger::Blocks
  belongs_to :category

  swagger_schema :Expense do
    key :required, [:id]
    property :id do
      key :type, :integer
    end
    property :expense_day do
      key :type, :string
      key :format, :date
    end
    property :value do
      key :type, :number
      key :format, :double
    end
  end

  validates :value, :numericality => { :greater_than_or_equal_to => 0 }
end
