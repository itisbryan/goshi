# frozen_string_literal: true

module Api
  module V1
    module Users
      class RegistrationController < ApplicationController
        def join
          result = Api::V1::Users::SignUp.call(params)
          success_response(result, 201, 'Create account successfully')
        end
      end
    end
  end
end
