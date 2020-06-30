class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :avatar_cache, :remove_avatar)
    end
end
