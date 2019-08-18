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
