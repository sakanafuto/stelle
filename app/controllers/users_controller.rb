class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @liked_posts = @user.liked_posts.includes(:prefecture)
  end

  def liked_posts; end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user
      flash[:success] = "プロフィールを更新！"
    else
      redirect_to edit_user_path(@user), flash: {
        user: @user,
        errors: @user.errors.full_messages
      }
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :avatar_cache, :remove_avatar)
  end
end
