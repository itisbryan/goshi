module Users
  class SessionsController < Devise::SessionsController
    before_action :validate_params, only: %i[create]

    respond_to :json

    def create
      self.resource = warden.authenticate(auth_options)
      raise Errors::Exceptions::InvalidEmailOrPassword, 'Unauthorized' unless resource.present?

      sign_in(resource_name, resource)
      token = generated_token(resource:)
      success_response({ token: }, 201, 'Authenticated')
    end

    private

    def validate_params
      ParamsValidator.new do
        mandatory :email, type: String
        mandatory :password, type: String, validate: ->(val) { val.length >= 6 && val.length <= 128 }
      end.build(sign_in_params)
    end

    def generated_token(resource:)
      JWT.encode(
        {
          user: {
            first_name: resource.first_name,
            last_name: resource.last_name,
            email: resource.email,
            application: Rails.application.engine_name
          }
        }, Rails.application.secrets.secret_key_base
      )
    end
  end
end
