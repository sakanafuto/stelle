class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:create, :destroy]

  def create
    @post.like(current_user) unless @post.already_liked?(current_user)
    respond_to do |format|
      format.html { redirect_to request.referer || root_url }
      format.js
    end
  end

  def destroy
    @post = Like.find(params[:id]).post
    @post.unlike(current_user)
    respond_to do |format|
      format.html { redirect_to request.referer || root_url }
      format.js
    end
  end

  private

    def set_post
      @post = Post.find(params[:post_id])
    end
end
