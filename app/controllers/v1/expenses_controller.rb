module V1
  class ExpensesController < ApplicationController
    include Swagger::Blocks

    before_action :set_category
    before_action :set_category_expense, only: [:show, :update, :destroy]

    swagger_path "/categories/{id}/expenses" do
      operation :get do
        key :summary, "Show Expenses for Category"
        key :description, "Returns all expenses for chosen category."
        key :tags, [
          "expenses",
          "categories"
        ]
        parameter do
          key :name, :id
          key :in, :path
          key :required, true
          key :type, :integer
          key :format, :int64
        end
        response 200 do
          key :description, "expenses response"
          schema do
            key :type, :array
            items do
              key :"$ref", :Expense
            end
          end
        end
        response :default do
          key :description, "unexpected error"
          schema do
            key :"$ref", :ErrorModel
          end
        end
        security do
          key :api_key, []
        end
      end
    end
    swagger_path "/categories/{id}/expenses/{id2}" do
      operation :get do
        key :summary, "Show specific"
        key :description, "Returns specific expenses for chosen id."
        key :tags, [
          "expenses",
          "categories"
        ]
        parameter do
          key :name, :id
          key :description, "Id of the Category"
          key :in, :path
          key :required, true
          key :type, :integer
          key :format, :int64
        end
        parameter do
          key :name, :id2
          key :description, "Id of the Expense"
          key :in, :path
          key :required, true
          key :type, :integer
          key :format, :int64
        end
        response 200 do
          key :description, "expenses response"
          schema do
            key :"$ref", :Expense
          end
        end
        response :default do
          key :description, "unexpected error"
          schema do
            key :"$ref", :ErrorModel
          end
        end
        security do
          key :api_key, []
        end
      end
    end

    def index
      return_resource(@category, @category.expenses)
    end

    def show
      return_resource(@category, @expense)
    end

    def create
      @category.expenses.create!(expense_params)
      json_response(@category, :created)
    end

    def update
      @expense.update(expense_params)
      head :no_content
    end

    def destroy
      @expense.destroy
      head :no_content
    end

    private
    def expense_params
      params.permit(:month, :planned_value, :value)
    end

    def set_category
      @category = Category.find(params[:category_id])
    end

    def set_category_expense
      @expense = @category.expenses.find_by!(id: params[:id]) if @category
    end
  end
end
