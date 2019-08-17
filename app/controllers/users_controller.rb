class UsersController < ApplicationController
  include Swagger::Blocks

  skip_before_action :authorize_request, only: :create

  swagger_path "/signup" do
    operation :post do
      key :summary, "Registers user"
      key :description, "Function to register user, returns API key. Use this key for Authorization."
      key :tags, [
        "users"
      ]
      parameter do
        key :name, :login
        key :in, :query
        key :required, true
        key :type, :string
      end
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
      parameter do
        key :name, :password_confirmation
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

  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  private
  def user_params
    params.permit(
      :login,
      :email,
      :password,
      :password_confirmation
    )
  end
end
