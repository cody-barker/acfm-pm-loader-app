class Api::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  
  def index
    users = User.includes(:loading_lists).all
    render json: users
  end

  def show
        user = User.includes(:loading_lists).find_by(id: session[:user_id])
        if user
            render json: user, status: :ok
        else
            render json: { error: "User not found" }, status: :not_found
        end
    end

  def create
   user = User.create!(user_params)
   render json: user, status: :created
  end

  def update
    @user.update!(user_params)
    render json: @user
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private 

  def set_user
    @user = User.includes(:loading_lists).find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :role)
  end 

end
