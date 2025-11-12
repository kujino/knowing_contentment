class PostsController < ApplicationController
  
  def new
    @post = Post.new
  end

  def create
    @post =Post.new(post_params)
    @post.save
    redirect_to mypage_path
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :content, :is_anonymous)
  end
end