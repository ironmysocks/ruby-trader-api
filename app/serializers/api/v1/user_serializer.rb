module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :first_name, :last_name, :email, :username
    end
  end
end
