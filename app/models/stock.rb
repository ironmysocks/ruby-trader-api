class Stock < ApplicationRecord

  validates_presence_of :symbol
  validates_uniqueness_of :symbol, scope: :watchlist_id

  attr_accessor :live_data

  after_initialize do
    @live_data = StockQuote::Stock.quote(self.symbol)
  end

  def last_price
    self.live_data.last_trade_price_only
  end

  def company
    self.live_data.name
  end

  def price_as_of
    self.live_data.last_trade_time
  end

  def change
    self.live_data.change
  end

  def fiftyma
    self.live_data.fiftyday_moving_average
  end

  def change_percent
    self.live_data.percent_change
  end
end
