class Balance < ApplicationRecord
  include Swagger::Blocks
  
  validates_presence_of :income, :created_by
  validates :income, :planned_savings, :numericality => { greater_than_or_equal_to: 0 }
  validates :month, :numericality => { greater_than: 0, less_than: 13, only_integer: true }

  swagger_schema :Balance do
    key :required, [:id]
    property :id do
      key :type, :integer
    end
    property :income do
      key :type, :number
      key :format, :double
    end
    property :month do
      key :type, :string
      key :format, :date
    end
    property :planned_savings do
      key :type, :number
      key :format, :double
    end
    property :savings do
      key :type, :number
      key :format, :double
    end
    property :created_by do
      key :type, :integer
    end
  end

  swagger_schema :BalanceInput do
    key :required, [:income, :planned_savings, :month]
    property :income do
      key :type, :number
      key :format, :double
    end
    property :month do
      key :type, :string
      key :format, :date
    end
    property :planned_savings do
      key :type, :number
      key :format, :double
    end
    property :savings do
      key :type, :number
      key :format, :double
    end
    property :created_by do
      key :type, :integer
    end
  end
end
