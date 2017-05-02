class UpdateStockholder < ActiveRecord::Migration[5.0]
  def change
    remove_column :stocks, :stockholder, :integer
    add_column :stocks, :stockholder_id, :integer
  end
end
