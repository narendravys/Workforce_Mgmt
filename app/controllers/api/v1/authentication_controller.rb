module Api
  module V1
    class AuthenticationController < ApplicationController
      skip_before_action :authorize_request, only: [:login, :signup]

      def login
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          token = JsonWebToken.encode(user_id: user.id)
          render json: { token: token, user: user.slice(:id, :name, :email, :role) }, status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end

      def signup
        user = User.new(user_params)
        if user.save
          token = JsonWebToken.encode(user_id: user.id)
          render json: { token: token, user: user.slice(:id, :name, :email, :role) }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :manager_id)
      end
    end
  end
end
