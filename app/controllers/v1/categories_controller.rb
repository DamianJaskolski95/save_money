module V1
  class CategoriesController < ApplicationController
    include Swagger::Blocks

    before_action :set_category, only: [:show, :update, :destroy]

    swagger_path "/categories" do
      operation :get do
        key :summary, "Show Categories with expenses."
        key :description, "Returns categories from the system that the user \
                      has access to."
        key :tags, [
          "categories"
        ]
        response 200 do
          key :description, "categories response"
          schema do
            key :type, :array
            items do
              key :"$ref", :Category
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
        key :summary, "Add Category"
        key :description, "Add one category to user categories."
        key :tags, [
          "categories"
        ]
        parameter :name
        parameter :category_savings
        parameter :category_planned_savings
        parameter :cycle_id
        response 200 do
          key :description, "category response"
          schema do
            key :"$ref", :CategoryInput
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

    swagger_path "/categories/{id}" do
      operation :get do
        key :summary, "Show Category"
        key :description, "Show category of provided id."
        key :tags, [
          "categories"
        ]
        parameter :id
        response 200 do
          key :description, "category response"
          schema do
            key :"$ref", :Category
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
        key :summary, "Update Category"
        key :description, "Change name of the category."
        key :tags, [
          "categories"
        ]
        parameter :id
        parameter :name
        parameter :category_savings
        parameter :category_planned_savings
        parameter :cycle_id
        response 200 do
          key :description, "category response"
          schema do
            key :"$ref", :Category
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
        key :summary, "Delete Category"
        key :description, "Delete Category"
        key :tags, [
          "categories"
        ]
        parameter :id
        response 200 do
          key :description, "category response"
          schema do
            property :message do
              key :type, :string
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
      @categories = current_user.categories
      json_response(@categories)
    end

    def create
      @category = current_user.categories.create!(category_params)
      json_response(@category, :created)
    end

    def show
      if current_user_resource?(@category)
        json_response(@category)
      else
        json_response(message: Message.unauthorized)
      end
    end

    def update
      if current_user_resource?(@category)
        if @category.update(category_params)
          json_response(@category)
        else
          json_response(message: Message.unique_value_used)
        end
      else
        json_response(message: Message.unauthorized)
      end
    end

    def destroy
      if current_user_resource?(@category)
        if @category.destroy
          json_response(message: Message.value_deleted)
        else
          json_response(message: Message.value_not_deleted)
        end
      else
        json_response(message: Message.unauthorized)
      end
    end

    def countz
      @category = Category.find(1)
      json_response(counted: count_category_value)
    end

    private

    def category_params
      params.permit(:id, :name, :category_savings, :category_planned_savings, :created_by)
    end

    def set_category
      @category = Category.find(params[:id])
    end

    def count_category_value
      category_value = 0.0
      @category.expenses.each do |expense|
        category_value += expense.value
      end
      category_value
    end
  end
end
