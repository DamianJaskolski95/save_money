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
        ]
        parameter :id
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
      operation :post do
        key :summary, "Add Expense for Category"
        key :description, "Adds expense for chosen category."
        key :tags, [
          "expenses",
        ]
        parameter :id
        parameter :date_form
        parameter :value
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
        ]
        parameter :id_expense_category
        parameter :id2_expense_category
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
      operation :put do
        key :summary, "Edits expense"
        key :description, "Edits specific category expense."
        key :tags, [
          "expenses",
        ]
        parameter :id_expense_category
        parameter :id2_expense_category
        parameter :date_form
        parameter :value
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
      operation :delete do
        key :summary, "Deletes expense"
        key :description, "Deletes specific category expense."
        key :tags, [
          "expenses",
        ]
        parameter :id_expense_category
        parameter :id2_expense_category
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

    def index
      if current_user_resource?(@category)
        json_response(@category.expenses)
      else
        json_response(message: Message.unauthorized)
      end
    end

    def show
      if current_user_resource?(@expense)
        json_response(@expense)
      else
        json_response(message: Message.unauthorized)
      end
    end

    def create
      if current_user_resource?(@category)
        set_date unless params[:expense_day]
        @expense = @category.expenses.create!(expense_params)
        json_response(@expense, :created)
      else
        json_response(message: Message.unauthorized)
      end
    end

    def update
      if current_user_resource?(@expense)
        if @expense.update(expense_params)
          json_response(@expense)
        else
          json_response(message: Message.unique_value_used)
        end
      else
        json_response(message: Message.unauthorized)
      end
    end

    def destroy
      if current_user_resource?(@expense)
        if @expense.destroy
          json_response(message: Message.value_deleted)
        else
          json_response(message: Message.value_not_deleted)
        end
      else
        json_response(message: Message.unauthorized)
      end
    end

    private
    def expense_params
      params.permit(:id, :expense_day, :value, :category_id, :created_by)
    end

    def set_category
      @category = Category.find(params[:category_id])
      params[:created_by] = current_user.id
    end

    def set_category_expense
      @expense = @category.expenses.find_by!(id: params[:id]) if @category
    end

    def set_date
      params[:expense_day] = Date.today
    end
  end
end
