module Errors::Exceptions
  class InvalidParams < StandardError; end

  class MissingParams < StandardError; end

  class InvalidEmailOrPassword < StandardError; end

  class InvalidToken < StandardError; end
end