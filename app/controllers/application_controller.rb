class ApplicationController < ActionController::API
  include Errors::BaseHandler
  include ApiHandler

  protected

  def authenticate_request!
    raise Errors::Exceptions::InvalidToken, 'Invalid token' unless user_id_in_token?

    @current_user = User.find(auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
    failure_response(:token_verify_error, 401, 'Could not verify token')
  end

  private

  def http_token
    @http_token ||= request.headers['Authorization'].split.last if request.headers['Authorization'].present?
  end

  def auth_token
    @auth_token ||= JwtWrapper.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i
  end
end
