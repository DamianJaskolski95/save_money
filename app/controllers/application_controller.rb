class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler

  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  before_action :authorize_request
  attr_reader :current_user

  private
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end

  def current_user_resource?(resource)
    if resource.created_by.to_i == current_user.id
      true
    else
      false
    end
  end
end
