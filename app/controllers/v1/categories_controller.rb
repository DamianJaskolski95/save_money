module V1
  class CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :update, :destroy]

    def index
      @categories = current_user.categories
      json_response(@categories)
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
      params.permit(:name)
    end

    def set_category
      @category = Category.find(params[:id])
    end
  end
end
