module Api
  module V1
    class PortfoliosController < ApiController
      before_action :set_portfolio_by_user, only: [:show_for_user]
      before_action :set_portfolio, only: [:show, :update, :destroy]

      # GET /v1/portfolios
      def index
        render json: Portfolio.all
      end

      # POST /v1/portfolios
      def create
        @portfolio = Portfolio.new(portfolio_params)
        if @portfolio.save
          render json: { message: 'Portfolio was added.' }
        else
          render json: { message: 'There was an error adding the portfolio.' }
        end
      end

      # GET /v1/portfolios/1
      def show
        render json: @portfolio
      end

      # PATCH/PUT /v1/portfolios/1
      def update
        if @portfolio.update(portfolio_params)
          render json: { message: 'Portfolio was updated.' }
        else
          render json: { message: 'There was an error updating the portfolio.' }
        end
      end

      # DELETE /v1/portfolios/1
      def destroy
        @portfolio.destroy
        render json: { message: 'The portfolio was deleted.' }
      end

      def show_for_user
        render json: @portfolio
      end

      private

      def set_portfolio
        @portfolio = Portfolio.find(params[:id])
      end

      def set_portfolio_by_user
        @portfolio = Portfolio.where(user_id: params[:id])
      end

      def portfolio_params
        params.require(:portfolio).permit(:user_id,
          stocks_attributes: [:id, :portfolio_id, :symbol, :_destroy])
      end

    end
  end
end
