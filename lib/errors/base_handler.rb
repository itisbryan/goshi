module Errors
  module BaseHandler
    extend ActiveSupport::Concern

    included do
      rescue_from ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid do |e|
        failure_response(:record_not_found, 422, e.message)
      end

      rescue_from Errors::Exceptions::MissingParams do |e|
        failure_response(:missing_params, 422, e.message)
      end

      rescue_from Errors::Exceptions::InvalidParams do |e|
        failure_response(:invalid_params, 422, e.message)
      end

      rescue_from Errors::Exceptions::InvalidEmailOrPassword do |e|
        failure_response(:invalid_email_or_password, 401, e.message)
      end

      rescue_from Errors::Exceptions::InvalidToken do |e|
        failure_response(:invalid_token, 401, e.message)
      end

      rescue_from Errors::Exceptions::InvalidResource do |e|
        failure_response(:invalid_resource, 422, e.message)
      end
    end
  end
end
