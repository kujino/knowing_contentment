class PostsController < ApplicationController
  before_action :post_show_authorize, only: [:show]

  def new
    @post = Post.new
    @today_theme = Theme.order("RANDOM()").first
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to mypage_path, notice: "投稿しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post
  end 

  private

  def post_params
    params.require(:post).permit(:content, :is_anonymous, :theme_id, :image)
  end

  def post_show_authorize
    @post = Post.find(params[:id])
    if @post.user != current_user
      redirect_to root_path, alert: "アクセス権がありません"
    end
  end 
end
