module V1
  class BalancesController < ApplicationController
    include Swagger::Blocks

    before_action :set_balance, only: [:show, :update, :destroy]

    swagger_path "/balances" do
      operation :get do
        key :summary, "Show balances."
        key :description, "Returns balances from the system that the user \
                      has access to."
        key :tags, [
          "balances"
        ]
        response 200 do
          key :description, "balances response"
          schema do
            key :type, :array
            items do
              key :"$ref", :Balance
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
        key :summary, "Add balance"
        key :description, "Add one cycle to user balances."
        key :tags, [
          "balances"
        ]
        parameter :income
        parameter :planned_savings
        parameter :savings
        parameter :month
        response 200 do
          key :description, "balance response"
          schema do
            key :"$ref", :BalanceInput
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

    swagger_path "/balances/{id}" do
      operation :get do
        key :summary, "Show balance"
        key :description, "Show balance of provided id."
        key :tags, [
          "balances"
        ]
        parameter :id
        response 200 do
          key :description, "balance response"
          schema do
            key :"$ref", :Balance
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
        key :summary, "Update balance"
        key :description, "Change data of the balance."
        key :tags, [
          "balances"
        ]
        parameter :id
        parameter :income
        parameter :planned_savings
        parameter :savings
        parameter :month
        response 200 do
          key :description, "balance response"
          schema do
            key :"$ref", :Balance
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
        key :summary, "Delete balance"
        key :description, "Delete balance"
        key :tags, [
          "balances"
        ]
        parameter :id
        response 200 do
          key :description, "balances response"
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
