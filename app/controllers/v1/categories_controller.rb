module V1
  class CategoriesController < ApplicationController
    include Swagger::Blocks

    before_action :set_category, only: [:show, :update, :destroy]

    swagger_path "/categories" do
      operation :get do
        key :summary, "Show Categories with expenses."
        key :description, "Returns categories from the system that the user \
                      has access to, 25 per page.\nCan get all with parameter \
                      change."
        key :tags, [
          "categories"
        ]
        parameter do
          key :name, :get_all
          key :in, :query
          key :required, false
          key :type, :boolean
        end
        parameter do
          key :name, :page
          key :in, :query
          key :required, false
          key :type, :string
        end
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
        parameter do
          key :name, :category
          key :in, :body
          key :description, "Category add to the user categories"
          key :required, true
          schema do
            key :"$ref", :CategoryInput
          end
        end
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

    def index
      if params[:get_all] == "true"
        @categories = current_user.categories
        json_response(@categories)
      else
        @categories = current_user.categories.paginate(page: params[:page], per_page:25)
        json_response(@categories)
      end
    end

    def create
      @category = current_user.categories.create!(category_params)
      json_response(@category, :created)
    end

    def show
      json_response(@category)
    end

    def update
      @category.update(category_params)
      head :no_content
    end

    def destroy
      @category.destroy
      head :no_content
    end

    private
    def category_params
      params.permit(:name, :get_all)
    end

    def set_category
      @category = Category.find(params[:id])
    end
  end
end
