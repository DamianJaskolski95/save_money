class ApidocsController < ActionController::Base
  include Swagger::Blocks

  swagger_root do
    key :swagger, "2.0"
    info do
      key :version, "1.0.0"
      key :title, "Better Savings"
      key :description, "Web Application to help you with your savings."
      contact do
        key :name, "Damian Jaskolski"
        key :email, "damian.jaskolski95@gmail.com"
      end
      license do
        key :name, "MIT"
      end
    end
    tag do
      key :name, "users"
      key :description, "Users operations"
    end
    tag do
      key :name, "categories"
      key :description, "Categories operations"
    end
    tag do
      key :name, "expenses"
      key :description, "Expenses operations"
    end
    key :basePath, "/"
    key :schemes, "http"
    key :consumes, ["application/json"]
    key :produces, ["application/json"]
    parameter :id do
      key :name, :id
      key :in, :path
      key :required, true
      key :type, :integer
      key :format, :int64
    end
    parameter :id_expense_category do
      key :name, :id
      key :description, "Id of the Category"
      key :in, :path
      key :required, true
      key :type, :integer
      key :format, :int64
    end
    parameter :id2_expense_category do
      key :name, :id2
      key :description, "Id of the Expense"
      key :in, :path
      key :required, true
      key :type, :integer
      key :format, :int64
    end
    parameter :email do
      key :name, :email
      key :in, :query
      key :required, true
      key :type, :string
    end
    parameter :password do
      key :name, :password
      key :in, :query
      key :required, true
      key :type, :string
      key :format, :password
    end
    parameter :name do
      key :name, :name
      key :in, :query
      key :description, "Category name"
      key :required, true
    end
    parameter :category_savings do
      key :name, :category_savings
      key :in, :query
      key :description, "Current value of the category savings."
      key :type, :number
      key :format, :double
    end
    parameter :category_planned_savings do
      key :name, :category_planned_savings
      key :in, :query
      key :description, "Planned value of the category savings."
      key :type, :number
      key :format, :double
    end
    parameter :cycle_id do
      key :name, :cycle_id
      key :in, :query
      key :type, :integer
      key :format, :int64
    end
    parameter :date_form do
      key :name, :expense_day
      key :in, :query
      key :description, "Date of the expense."
      key :type, :string
      key :format, :date
    end
    parameter :value do
      key :name, :value
      key :in, :query
      key :description, "Current value of the expense."
      key :type, :number
      key :format, :double
    end
    parameter :planned_value do
      key :name, :planned_value
      key :in, :query
      key :type, :number
      key :format, :double
    end
    parameter :start_day do
      key :name, :start_day
      key :in, :query
      key :type, :string
      key :format, :date
    end
    parameter :end_day do
      key :name, :end_day
      key :in, :query
      key :type, :string
      key :format, :date
    end
    parameter :duration do
      key :name, :duration
      key :in, :query
      key :type, :integer
    end
    parameter :balance_id do
      key :name, :balance_id
      key :in, :query
      key :type, :integer
    end
    parameter :income do
      key :name, :income
      key :in, :query
      key :type, :number
      key :format, :double
    end
    parameter :planned_savings do
      key :name, :planned_savings
      key :in, :query
      key :type, :number
      key :format, :double
    end
    parameter :savings do
      key :name, :savings
      key :in, :query
      key :type, :number
      key :format, :double
    end
    parameter :balance_date do
      key :name, :balance_date
      key :in, :query
      key :type, :string
      key :format, :date
    end
    parameter :cycle_value do
      key :name, :cycle_value
      key :in, :query
      key :type, :number
      key :format, :double
    end
    security_definition :api_key do
      key :type, :apiKey
      key :name, :Authorization
      key :in, :header
    end
  end

  SWAGGERED_CLASSES = [
    V1::BalancesController,
    Balance,
    V1::CategoriesController,
    Category,
    V1::CyclesController,
    Cycle,
    V1::ExpensesController,
    Expense,
    UsersController,
    User,
    AuthenticationController,
    ErrorModel,
    self,
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end
