class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler

  protect_from_forgery with: :null_session
  before_action :authorize_request
  attr_reader :current_user

  private
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end

  def current_user_resource?(resource)
    if resource.created_by.to_i == current_user.id
      return true
    else
      return false
    end
  end

  def return_resource(parent, resource)
    if parent.created_by.to_i == current_user.id
        json_response(resource)
    else
        json_response(message: Message.unauthorized)
    end
  end
end
