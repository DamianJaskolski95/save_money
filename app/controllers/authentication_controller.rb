class AuthenticationController < ApplicationController
  include Swagger::Blocks
  skip_before_action :authorize_request, only: :authenticate

  swagger_path "/auth/login" do
    operation :post do
      key :summary, "Login to application."
      key :description, "You can login on your previously created account. Api key is generated."
      key :tags, [
        "users"
      ]
      parameter do
        key :name, :email
        key :in, :query
        key :required, true
        key :type, :string
      end
      parameter do
        key :name, :password
        key :in, :query
        key :required, true
        key :type, :string
        key :format, :password
      end
      response 200 do
        key :description, "users response"
        schema do
          key :type, :array
          items do
            key :"$ref", :User
          end
        end
      end
      response :default do
        key :description, "unexpected error"
        schema do
          key :"$ref", :ErrorModel
        end
      end
    end
  end

  def authenticate
    auth_token =
      AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token)
  end

  private
  def auth_params
    params.permit(:email, :password)
  end
end
