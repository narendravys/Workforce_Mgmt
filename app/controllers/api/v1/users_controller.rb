module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: %i[show update destroy]
      before_action :authorize_hr_admin, only: [:create, :update, :destroy]

      def index
        @users = current_user.accessible_users
        render json: @users
      end


      def show
        render json: @user
      end

      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user, status: :created
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @user.update(user_params)
          render json: @user
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @user.destroy
        head :no_content
      end

      private

      def set_user
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "User not found" }, status: :not_found
      end

      def user_params
        params.require(:user).permit(:name, :email, :role, :manager_id)
      end

      def authorize_hr_admin
        unless current_user.hr? || current_user.admin? || current_user.super_admin?
          render json: { error: "Unauthorized" }, status: :forbidden
        end
      end
    end
  end
end
