class JwtWrapper
    def self.encode(payload)
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def self.decode(token)
      return HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.secrets.secret_key_base).first)
    rescue
      nil
    end
end
