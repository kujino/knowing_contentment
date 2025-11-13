class PostsController < ApplicationController
  def new
    @post = Post.new
    @today_theme = Theme.first
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to mypage_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :is_anonymous)
  end
end
