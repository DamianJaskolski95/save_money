module V1
  class CyclesController < ApplicationController
    include Swagger::Blocks

    before_action :set_cycle, only: [:show, :update, :destroy]

    swagger_path "/cycles" do
      operation :get do
        key :summary, "Show Cycles."
        key :description, "Returns cycles from the system that the user \
                      has access to."
        key :tags, [
          "cycles"
        ]
        response 200 do
          key :description, "cycles response"
          schema do
            key :type, :array
            items do
              key :"$ref", :Cycle
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
        key :summary, "Add Cycle"
        key :description, "Add one cycle to user cycles."
        key :tags, [
          "cycles"
        ]
        parameter :planned_value
        parameter :cycle_value
        parameter :start_day
        parameter :end_day
        parameter :duration
        parameter :balance_id
        response 200 do
          key :description, "cycle response"
          schema do
            key :"$ref", :CycleInput
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

    swagger_path "/cycles/{id}" do
      operation :get do
        key :summary, "Show cycle"
        key :description, "Show cycle of provided id."
        key :tags, [
          "cycles"
        ]
        parameter :id
        response 200 do
          key :description, "cycle response"
          schema do
            key :"$ref", :Cycle
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
        key :summary, "Update cycle"
        key :description, "Change data of the cycle."
        key :tags, [
          "cycles"
        ]
        parameter :id
        parameter :planned_value
        parameter :cycle_value
        parameter :start_day
        parameter :end_day
        parameter :duration
        parameter :balance_id
        response 200 do
          key :description, "cycle response"
          schema do
            key :"$ref", :Cycle
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
        key :summary, "Delete cycle"
        key :description, "Delete cycle"
        key :tags, [
          "cycles"
        ]
        parameter :id
        response 200 do
          key :description, "cycles response"
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
      @cycles = current_user.cycles
      json_response(@cycles)
    end

    def show
      if current_user_resource?(@cycle)
        json_response(@cycle)
      else
        json_response(message: Message.unauthorized)
      end
    end

    def create
      set_days
      @cycle = current_user.cycles.create!(cycle_params)
      json_response(@cycle, :created)
    end

    def update
      if current_user_resource?(@cycle)
        if @cycle.update(cycle_params)
          json_response(@cycle)
        else
          json_response(message: Message.unique_value_used)
        end
      else
        json_response(message: Message.unauthorized)
      end
    end

    def destroy
      if current_user_resource?(@cycle)
        if @cycle.destroy
          json_response(message: Message.value_deleted)
        else
          json_response(message: Message.value_not_deleted)
        end
      else
        json_response(message: Message.unauthorized)
      end
    end

    private
    def cycle_params
      params.permit(:id, :planned_value, :cycle_value, :start_day, :duration, :end_day, :created_by, :balance_id)
    end

    def set_cycle
      @cycle = Cycle.find(params[:id])
    end

    def set_days
      if params[:start_day]
        params[:start_day] = Date.parse(params[:start_day])
      else
        params[:start_day] = Date.today
      end
      params[:end_day] = params[:start_day] + 30.days unless params[:end_day]
    end
  end
end
