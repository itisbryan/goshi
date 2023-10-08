  class GlobalStateSerializer < ActiveModel::Serializer
    attributes :email, :first_name, :last_name, :username

    def username
      object&.login
    end
  end
