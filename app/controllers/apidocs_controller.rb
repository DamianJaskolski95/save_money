class ApidocsController < ActionController::Base
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'Better Savings'
      key :description, 'Web Application to help you with your savings.'
      contact do
        key :name, 'Damian Jaskolski'
        key :email, 'damian.jaskolski95@gmail.com'
      end
      license do
        key :name, 'MIT'
      end
    end
    tag do
      key :name, 'categories'
      key :description, 'Categories operations'
    end
    key :basePath, '/'
    key :schemes, 'http'
    key :consumes, ['application/json']
    key :produces, ['application/json']

    security_definition :api_key do
      key :type, :apiKey
      key :name, :Authorization
      key :in, :header
    end
  end

  SWAGGERED_CLASSES = [
    V1::CategoriesController,
    V1::Category,
    ErrorModel,
    self,
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end