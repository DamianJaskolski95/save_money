class Category < ApplicationRecord
  include Swagger::Blocks
  has_many :expenses, dependent: :destroy
  belongs_to :cycle
  validates_presence_of :name, :created_by
  validates_uniqueness_of :name, scope: :cycle_id

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
    property :category_savings do
      key :type, :integer
    end
    property :category_planned_savings do
      key :type, :integer
    end
    property :cycle_id do
      key :type, :integer
    end
    property :expenses do
      key :type, :array
      items do
        key :"$ref", :Expense
      end
    end
  end

  swagger_schema :CategoryInput do
    property :name do
      key :type, :string
    end
    property :category_savings do
      key :type, :integer
    end
    property :category_planned_savings do
      key :type, :integer
    end
    property :cycle_id do
      key :type, :integer
    end
  end
end
