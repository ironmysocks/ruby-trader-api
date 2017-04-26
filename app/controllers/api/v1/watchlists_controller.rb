module Api
  module V1
    class WatchlistsController < ApiController
      before_action :set_watchlist_by_user, only: [:show_for_user]
      before_action :set_watchlist, only: [:show, :update, :destroy,
                                          :move_stock_to_portfolio]

      # GET /v1/watchlists
      def index
        render json: Watchlist.all
      end

      # POST /v1/watchlists
      def create
        @watchlist = Watchlist.new(watchlist_params)
        if @watchlist.save
          render json: { message: 'Watchlist was added.' }
        else
          render json: { message: 'There was an error adding the watchlist.' }
        end
      end

      # GET /v1/watchlists/1
      def show
        render json: @watchlist
      end

      # GET /v1/users/1/watchlists
      # Get all watchlists for the user
      def show_for_user
        render json: @watchlist
      end

      # PUT /v1/watchlists/1
      def update
        if @watchlist.update(watchlist_params)
          render json: { message: 'Watchlist was updated.' }
        else
          render json: { message: 'There was an error updating the watchlist.' }
        end
      end

      # DELETE /v1/watchlists/1
      def destroy
        @watchlist.destroy
        render json: { message: 'The watchlist was deleted.' }
      end

      def move_stock_to_portfolio
        s = @watchlist.stocks.where(symbol: params[:symbol].upcase)

        if !s.blank?
          if s.update({watchlist_id: nil, portfolio_id: @watchlist.user.portfolio.id})
            render json: { message: "#{s.symbol} was moved to the portfolio." }
          else
            render json: { message: "There was an error moving the stock." }
          end
        else
          render json: { message: "The stock doesn't exist in the watchlist." }
        end

      end

      private
      def set_watchlist
        @watchlist = Watchlist.find(params[:id])
      end

      def set_watchlist_by_user
        @watchlist = Watchlist.where(user_id: params[:id])
      end

      def watchlist_params
        params.require(:watchlist).permit(:user_id, :name,
          stocks_attributes: [:id, :watchlist_id, :symbol, :_destroy])
      end

    end
  end
end
