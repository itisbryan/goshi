# frozen_string_literal: true

module Api
  module V1
    module Users
      class SignUp
        include BaseService
        attr_reader :params

        def initialize(params)
          @params = params
        end

        def call
          user = User.build(validated_params[:user])
          raise Errors::Exceptions::InvalidParams, 'Some thing went wrong' unless user.save

          GlobalStateSerializer.new(user)
        end

        private

        def validated_params
          @validated_params ||= ParamsValidator.new do
            mandatory :user, type: Hash do
              mandatory :email, type: String, validate: ->(val) { val.match(URI::MailTo::EMAIL_REGEXP) }
              mandatory :password, type: String, validate: ->(val) { val.length >= 6 && val.length <= 128 }
              mandatory :login, type: String
              mandatory :first_name, type: String
              mandatory :last_name, type: String
            end
          end.build(@params)
        end
      end
    end
  end
end
