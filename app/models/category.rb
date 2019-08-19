class Category < ApplicationRecord
  include Swagger::Blocks
  has_many :expenses, dependent: :destroy
  validates_presence_of :name, :created_by
  validates_uniqueness_of :name, scope: :created_by

  swagger_schema :Category do
    key :required, [:id, :name, :created_by]
    property :id do
      key :type, :integer
    end
    property :name do
      key :type, :string
    end
    property :created_by do
      key :type, :integer
    end
    property :created_at do
      key :type, :string
      key :format, :"date-time"
    end
    property :updated_at do
      key :type, :string
      key :format, :"date-time"
    end
    property :expenses do
      key :type, :array
      items do
        key :"$ref", :Expense
      end
    end
  end

  swagger_schema :CategoryInput do
    key :required, [:name]
    property :name do
      key :type, :string
    end

  end
end
