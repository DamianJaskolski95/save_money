class ExpensesController < ApplicationController
  before_action :set_category
  before_action :set_category_expense, only: [:show, :update, :destroy]

  def index
    json_response(@category.expenses)
  end

  def show
    json_response(@expense)
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
