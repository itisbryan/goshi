# frozen_string_literal: true

module Api
  module V1
    module Users
      class SessionsController < ApplicationController
        def new
          redirect_to '/'
        end

        def login
          result = Api::V1::Users::MakeAuthentication.call(params)
          success_response(result, 201, 'Authenticated')
        end
      end
    end
  end
end
