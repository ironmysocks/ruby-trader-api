module Api
  module V1
    class PortfolioSerializer < ActiveModel::Serializer
      belongs_to :user
      belongs_to :stocks
    end
  end
end
