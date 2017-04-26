module Api
  module V1
    class StockSerializer < ActiveModel::Serializer
      attributes :id, :symbol, :company, :last_price, :price_as_of, :change, :fiftyma, :change_percent
    end
  end
end
