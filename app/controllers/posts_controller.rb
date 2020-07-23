class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_target_post,    only: [:show, :edit, :update, :destroy]
  before_action :correct_user,       only: [:edit, :update, :destroy]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true)
  end

  def new
    @post = Post.new
  end

  def show
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "Stelleを投稿しました！"
      redirect_to @post
    else
      redirect_to new_post_path, flash: {
        post: @post,
        errors: @post.errors.full_messages
      }
    end
  end

  def destroy
    if @post.destroy
      redirect_to root_path
      flash[:success] = "Stelleを削除しました"
    else
      redirect_to new_post_path, flash: {
        post: @post,
        errors: @post.errors.full_messages
      }
    end
  end

  private
  
      def post_params
        params.require(:post).permit(:name, :caption, :user_id, :image, :prefecture_id)
      end

      def set_target_post
        @post = Post.find(params[:id])
      end

      def correct_user
        redirect_to(root_url) unless (@post.user == current_user) || current_user.admin?
      end
end
