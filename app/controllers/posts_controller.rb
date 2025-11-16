class PostsController < ApplicationController

  def new
    @post = Post.new
    @today_theme = Theme.order("RANDOM()").first
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to mypage_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end 

  private

  def post_params
    params.require(:post).permit(:content, :is_anonymous, :theme_id)
  end
end
