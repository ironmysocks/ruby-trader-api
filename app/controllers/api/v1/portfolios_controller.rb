module Api
  module V1
    class PortfoliosController < ApiController
      include ParameterChecker

      before_action :set_portfolio_by_user, only: [:show_for_user]
      before_action :set_portfolio, only: [:show, :update, :destroy]

      # GET /v1/portfolios
      def index
        json_response(Portfolio.all)
      end

      # POST /v1/portfolios
      def create
        @portfolio = Portfolio.create!(portfolio_params)
        json_response(@portfolio,:created)
      end

      # GET /v1/portfolios/1
      def show
        json_response(@portfolio)
      end

      def show_for_user
        json_response(@portfolio)
      end

      # PATCH/PUT /v1/portfolios/1
      def update
        @portfolio.update(portfolio_params)
        head :no_content
      end

      # DELETE /v1/portfolios/1
      def destroy
        @portfolio.destroy
        head :no_content
      end

      private

      def set_portfolio
        @portfolio = Portfolio.find(params[:id])
      end

      def set_portfolio_by_user
        @portfolio = Portfolio.find_by!(user_id: params[:id])
      end

      def portfolio_params
        params.require(:portfolio).permit(portfolios_allowed_params)
      end

    end
  end
end
