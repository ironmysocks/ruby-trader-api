module Api
  module V1
    class StocksController < ApiController
      include ParameterChecker
      before_action :find_stockholder
      before_action :set_stock, only: [:show, :update, :destroy]

      # GET /v1/watchlists/1/stocks
      def index
        json_response(@stockholder.stocks)
      end

      # GET /v1/watchlists/1/stocks/1
      def show
        json_response(@stock)
      end

      # POST /v1/watchlists/1/stocks
      def create
        @stockholder.stocks.create!(stock_params)
        json_response(@stockholder,:created)
      end

      # PATCH/PUT /v1/watchlists/1/stocks/1
      def update
        @stock.update(stock_params)
        head :no_content
      end

      # DELETE /v1/watchlists/1/stocks/1
      def destroy
        @stock.destroy
        head :no_content
      end

      private

      def set_stock
        @stock = @stockholder.stocks.find_by!(id: params[:id]) if @stockholder
      end

      def stock_params
        params.require(:stock).permit(stocks_allowed_params)
      end

      def find_stockholder
        params.each do |name, value|
          if name =~ /(.+)_id$/
            @stockholder =  $1.classify.constantize.find(value)
          end
        end
        @stockholder
      end

    end
  end
end
