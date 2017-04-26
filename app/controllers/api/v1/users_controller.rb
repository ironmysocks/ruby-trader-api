module Api
  module V1
    class UsersController < ApiController
      before_action :set_user, only: [:show, :update, :destroy, :get_portfolio, :get_watchlists]

      # GET /v1/users
      def index
        render json: User.all
      end

      # GET /v1/users/:id/portfolio
      def get_portfolio
        render json: @user.portfolio
      end

      # GET /v1/users/:id/watchlists
      def get_watchlists
        render json: @user.watchlists
      end

      # POST /v1/users
      # Creates new user with default portfolio
      def create
        @user = User.new(user_params)
        if @user.save
          msg = 'User was added.'
          if @user.portfolio.create
            msg << ' Portfolio was created.'
          else
            msg << ' There was an error creating the portfolio.'
          end
        else
          msg = 'There was an error adding the user.'
        end
        render json: { message: msg }
      end

      # GET /v1/users/1
      def show
        render json: @user
      end

      # PATCH/PUT /v1/users/1
      def update
        if @user.update(user_params)
          render json: { message: 'User was updated.' }
        else
          render json: { message: 'There was an error updating the user.' }
        end
      end

      # DELETE /v1/users/1
      def destroy
        @user.destroy
        render json: { message: 'The user was deleted.' }
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:first_name,:last_name,:email,:password)
      end

    end
  end
end
