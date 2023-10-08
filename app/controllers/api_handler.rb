module ApiHandler
  extend ActiveSupport::Concern

  included do
    def success_response(details, status, message)
      render_response(details, status, message)
    end

    def failure_response(errors, status, message)
      render_response(errors, status, message)
    end

    private

    def render_response(details, status, message)
      render json: { status:, message:, details: }, status:
    end
  end
end
