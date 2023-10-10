module Api
  module V1
    module Users
      class UserInfoController < ApplicationController
        before_action :authenticate_request!

        def global_state
          success_response(GlobalStateSerializer.new(@current_user), 201, 'Created')
        end
      end
    end
  end
end
