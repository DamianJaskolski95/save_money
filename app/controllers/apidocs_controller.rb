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
    parameter :category_input do
      key :name, :name
      key :in, :query
      key :description, "Category name"
      key :required, true
      schema do
        key :"$ref", :CategoryInput
      end
    end
    parameter :date_form do
      key :name, :date
      key :in, :query
      key :description, "Date of the expense."
      key :type, :string
      key :format, :date
    end
    parameter :planned_value do
      key :name, :planned_value
      key :in, :query
      key :description, "Planned value for expense."
      key :type, :number
      key :format, :double
    end
    parameter :value do
      key :name, :value
      key :in, :query
      key :description, "Current value of the expense."
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
    V1::CategoriesController,
    Category,
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
