module Api
  module V1
    class WatchlistSerializer < ActiveModel::Serializer
      attributes :id, :name, :user_id
      belongs_to :user
      belongs_to :stocks
    end
  end
end
