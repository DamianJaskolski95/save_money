module V1
  class BalancesController < ApplicationController
    before_action :set_balance, only: [:show, :update, :destroy]

    def index
      if params[:get_all] == "true"
        @balances = current_user.balances
        json_response(@balances)
      else
        @balances = current_user.balances.paginate(page: params[:page], per_page:25)
        json_response(@balances)
      end
    end

    def create
      @balance = current_user.balances.create!(balance_params)
      json_response(@balance, :created)
    end

    def show
      if current_user_resource?(@balance)
        json_response(@balance)
      else
        json_response(message: Message.unauthorized)
      end
    end

    def update
      if current_user_resource?(@balance)
        if @balance.update(balance_params)
          json_response(@balance)
        else
          json_response(message: Message.invalid_value)
        end
      else
        json_response(message: Message.unauthorized)
      end
    end

    def destroy
      if current_user_resource?(@balance)
        if @balance.destroy
          json_response(message: Message.value_deleted)
        else
          json_response(message: Message.value_not_deleted)
        end
      else
        json_response(message: Message.unauthorized)
      end
    end

    private
    def balance_params
      params.permit(:id, :income, :planned_savings, :savings, :month, :get_all, :created_by)
    end

    def set_balance
      @balance = Balance.find(params[:id])
    end
  end
end
