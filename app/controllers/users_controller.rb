class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :destroy]

  def show
    @user = User.find(params[:id])
    @liked_posts = @user.liked_posts.includes(:prefecture)
  end

  def liked_posts; end

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "ユーザー「#{@user.name}」は正常に削除されました"
    redirect_to users_path
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

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
