# frozen_string_literal: true

module Api
  module V1
    module Users
      class SessionsController < ApplicationController
        def new
          redirect_to '/'
        end

        def login
          user = User.find_for_database_authentication(email: validated_params[:user][:email])
          if user&.valid_password?(validated_params[:user][:password])
            success_response(payload(user:), 201, 'Authenticated')
          else
            failure_response(:invalid_email_or_password, 401, 'Unauthorized')
          end
        end

        private

        def payload(user:)
          raise ActiveRecord::RecordNotFound, 'User not found' unless user&.id

          {
            access_token: JwtWrapper.encode({ user_id: user.id }),
            user: { email: user.email, username: user.login, first_name: user.first_name, last_name: user.last_name }
          }
        end

        def validated_params
          @validated_params ||= ParamsValidator.new do
            mandatory :user, type: Hash do
              mandatory :email, type: String, validate: ->(val) { val.match(URI::MailTo::EMAIL_REGEXP) }
              mandatory :password, type: String, validate: ->(val) { val.length >= 6 && val.length <= 128 }
            end
          end.build(params)
        end
      end
    end
  end
end
