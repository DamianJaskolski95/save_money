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
        parameter :planned_value
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
        parameter :planned_value
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
        expense_day_not_provided = true unless params[:expense_day]
        if expense_day_not_provided || is_valid_date?(params[:expense_day])
          expense = @category.expenses.create!(expense_params)
          if expense
            set_date(expense) if expense_day_not_provided
            json_response(@category, :created)
          else
            json_response(message: Message.unknown_error)
          end
        else
          json_response(message: Message.invalid_date)
        end
      else
        json_response(message: Message.unauthorized)
      end
    end

    def update
      if current_user_resource?(@expense)
        expense_day_not_provided = true unless params[:expense_day]
        if expense_day_not_provided || is_valid_date?(params[:expense_day])
          if @expense.update(expense_params)
            json_response(@expense)
          else
            json_response(message: Message.unknown_error)
          end
        else
          json_response(message: Message.invalid_date)
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
      params.permit(:id, :expense_day, :planned_value, :value)
    end

    def set_category
      @category = Category.find(params[:category_id])
    end

    def set_category_expense
      @expense = @category.expenses.find_by!(id: params[:id]) if @category
    end

    def set_date(expense)
      params[:expense_day] = expense.created_at.strftime '%Y-%m-%d'
      expense.update(expense_params)
    end

    def is_valid_date?(check_date)
      check_date = check_date.split('-')
      if Date.valid_date?(check_date[0].to_i, check_date[1].to_i, check_date[2].to_i)
        return true
      else
        return false
      end
    end
  end
end
