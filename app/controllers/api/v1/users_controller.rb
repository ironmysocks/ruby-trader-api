module Api
  module V1
    class UsersController < ApiController
      include ParameterChecker

      skip_before_action :authorize_request, only: :create
      before_action :set_user, only: [:get_portfolio, :get_watchlists]

      # POST /signup
      # return authenticated token upon signup
      def create
        user = User.create!(user_params)
        auth_token = AuthenticateUser.new(user.email, user.password).call
        response = { message: Message.account_created, auth_token: auth_token }
        json_response(response, :created)
      end

      def portfolio
        @user.portfolio
      end

      def watchlists
        @user.watchlists
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.permit(users_allowed_params)
      end

    end
  end
end
