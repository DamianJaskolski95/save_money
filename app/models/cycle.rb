class Cycle < ApplicationRecord
  include Swagger::Blocks
  belongs_to :balance

  validates_presence_of :created_by, :start_day, :end_day
  validates_uniqueness_of :balance, scope: :created_by

  swagger_schema :Cycle do
    key :required, [:id]
    property :id do
      key :type, :integer
    end
    property :planned_value do
      key :type, :integer
      key :format, :decimal
    end
    property :start_day do
      key :type, :string
      key :format, :date
    end
    property :end_day do
      key :type, :string
      key :format, :date
    end
    property :duration do
      key :type, :integer
    end
    property :created_by do
      key :type, :integer
    end
  end

  swagger_schema :CycleInput do
    property :planned_value do
      key :type, :integer
      key :format, :decimal
    end
    property :start_day do
      key :type, :string
      key :format, :date
    end
    property :end_day do
      key :type, :string
      key :format, :date
    end
    property :duration do
      key :type, :integer
    end
    property :created_by do
      key :type, :integer
    end
  end
end
