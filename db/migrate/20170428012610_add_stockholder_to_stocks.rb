class AddStockholderToStocks < ActiveRecord::Migration[5.0]
  def change
    add_column :stocks, :stockholder, :integer
    add_column :stocks, :stockholder_type, :string
    remove_column :stocks, :watchlist_id
    remove_column :stocks, :portfolio_id
  end
end
