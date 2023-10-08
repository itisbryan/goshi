module Errors::Exceptions
  class InvalidParams < StandardError; end

  class MissingParams < StandardError; end

  class InvalidEmailOrPassword < StandardError; end
end