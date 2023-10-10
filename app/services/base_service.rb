module BaseService
  extend ActiveSupport::Concern

  included do
    def self.call(...)
      new(...).call
    end
  end
end
