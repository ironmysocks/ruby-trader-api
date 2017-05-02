module Api
  module V1
    class PortfolioSerializer < ActiveModel::Serializer
      attributes :id, :user_id
      belongs_to :user
      belongs_to :stocks
    end
  end
end
