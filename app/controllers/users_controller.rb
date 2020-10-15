class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[index create edit update destroy]
  before_action :set_target_user,    only: %i[show edit update destroy]
  before_action :admin_user,         only: %i[index destroy]

  def index
    @users = User.all
  end

  def show
    @liked_posts = @user.liked_posts.includes(:prefecture)
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      redirect_to @user
      flash[:success] = 'プロフィールを更新！'
    else
      redirect_to edit_user_path(@user), flash: {
        user: @user,
        errors: @user.errors.full_messages
      }
    end
  end

  def destroy
    @user.destroy
    flash[:alert] = "ユーザー「#{@user.name}」は正常に削除されました"
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :avatar_cache, :remove_avatar)
  end

  def set_target_user
    @user = User.find(params[:id])
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
