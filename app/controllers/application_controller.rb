class ApplicationController < ActionController::API
  include Errors::BaseHandler
  include ApiHandler

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :login])
  end
end
