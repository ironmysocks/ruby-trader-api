Rails.application.routes.draw do
  #devise_for :users
  scope module: 'api' do
    namespace :v1 do

      resources :users
      resources :watchlists
      resources :portfolios
      resources :stocks

      # More Portfolio functions
      get 'users/:id/portfolio', to: 'portfolios#show_for_user'

      # More Watchlist functions
      get 'users/:id/watchlists', to: 'watchlists#show_for_user'
      put 'watchlists/:id/move/:symbol', to: 'watchlists#move_stock_to_portfolio'

    end
  end
end
