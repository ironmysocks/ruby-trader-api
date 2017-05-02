Rails.application.routes.draw do

  scope module: 'api' do
    namespace :v1 do

      # Login items
      post 'auth/login', to: 'authentication#authenticate'
      post 'signup', to: 'users#create'

      # Portfolio functions
      resources :portfolios do
        resources :stocks
      end
      get 'portfolios/user/:id', to: 'portfolios#show_for_user'

      # Watchlist functions
      resources :watchlists do
        resources :stocks
      end
      get 'watchlists/user/:id', to: 'watchlists#show_for_user'
      put 'watchlists/:id/stocks/:stock_id/to_portfolio', to: 'watchlists#move_stock_to_portfolio'

    end
  end
end
