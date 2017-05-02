module Api
  module V1
    class WatchlistsController < ApiController
      include ParameterChecker
      before_action :set_watchlist_by_user, only: [:show_for_user]
      before_action :set_watchlist, only: [:show, :update, :destroy,
                                          :move_stock_to_portfolio]

      # GET /v1/watchlists
      def index
        @watchlist = current_user.watchlists
        json_response(@watchlist)
      end

      # POST /v1/watchlists
      def create
        @watchlist = current_user.watchlists.create!(watchlist_params)
        json_response(@watchlist, :created)
    end

      # GET /v1/watchlists/1
      def show
        json_response(@watchlist)
      end

      # GET /v1/users/1/watchlists
      # Get all watchlists for the user
      def show_for_user
        json_response(@watchlist)
      end

      # PUT /v1/watchlists/1
      def update
        @watchlist.update(watchlist_params)
        head :no_content
      end

      # DELETE /v1/watchlists/1
      def destroy
        @watchlist.destroy
        head :no_content
      end

      def move_stock_to_portfolio
        s = Stock.find(params[:stock_id])
        portfolio_id = Portfolio.find_by(user_id: @watchlist.user.id).id
        s.update({stockholder_id: portfolio_id, stockholder_type: 'Portfolio'})
        head :no_content
      end

      private
      def set_watchlist
        @watchlist = Watchlist.find(params[:id])
      end

      def set_watchlist_by_user
        @watchlist = Watchlist.find_by!(user_id: params[:id])
      end

      def watchlist_params
        params.require(:watchlist).permit(watchlists_allowed_params)
      end

    end
  end
end
