class CreateDatabase < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.timestamps
    end

    create_table :portfolios do |t|
      t.belongs_to :user, index: true, unique: true
      t.timestamps
    end

    create_table :watchlists do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.timestamps
    end

    create_table :stocks do |t|
      t.belongs_to :portfolio, index: true
      t.belongs_to :watchlist, index: true
      t.string :type
      t.string :symbol
      t.float :alert_price
      t.float :target_entry
      t.float :target_exit
      t.float :target_stop
      t.float :risk_amount
      t.float :reward_amount
      t.float :entry_price
      t.datetime :entry_date
      t.integer :shares
      t.float :exit_price
      t.datetime :exit_date
      t.float :realized_pl
      t.timestamps
    end
  end
end
