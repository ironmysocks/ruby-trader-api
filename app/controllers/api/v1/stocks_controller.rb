module Api
  module V1
    class StocksController < ApiController
      before_action :set_stock, only: [:show, :update, :destroy]

      # GET /v1/stocks
      def index
        render json: Stock.all
      end

      # GET /v1/stocks/1
      def show
        render json: @stock
      end

      # POST /v1/stocks
      def create
        @stock = Stock.new(stock_params)
        if @stock.save
          render json: { message: 'Stock was added.' }
        else
          render json: { message: 'There was an error adding the stock.' }
        end
      end

      # PATCH/PUT /v1/stocks/aapl
      def update
        if @stock.update(stock_params)
          render json: { message: 'Stock was updated.' }
        else
          render json: { message: 'There was an error updating the stock.' }
        end
      end

      # DELETE /v1/stocks/aapl
      def destroy
        @stock.destroy
        render json: { message: 'The stock was deleted.' }
      end

      private
      def set_stock
        @stock = Stock.find_or_create_by(params[:id])
      end

      def stock_params
        params.require(:stock).permit(:id, :portfolio_id, :watchlist_id, :symbol, :alert_price
                                      :target_entry, :target_exit, :target_stop, :risk_amount,
                                      :reward_amount, :entry_price, :entry_date, :shares,
                                      :exit_price, :exit_date, :realized_pl)
      end

    end
  end
end
