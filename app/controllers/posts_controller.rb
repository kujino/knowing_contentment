class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]
  before_action :post_authorize, only: [ :show, :edit, :update, :destroy ]

  def index
    @posts = Post.includes(:user, :theme, image_attachment: :blob).order(created_at: :desc)
  end

  def new
    if current_user.posts.where(created_at: Time.current.all_day).exists?
      redirect_to request.referrer || root_path, notice: "今日は投稿済みです、また明日みつけてね"
    else
      @post = Post.new
      @today_theme = Theme.order("RANDOM()").first
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to post_path(@post), notice: "投稿しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post
  end

  def edit
    @post
  end

  def update
    @post
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post
    @post.destroy!
    redirect_to mypage_path, notice: "削除しました"
  end



  private

  def post_params
    params.require(:post).permit(:content, :is_anonymous, :theme_id, :image)
  end

  # 投稿ポストユーザー以外アクセス不可
  def post_authorize
    @post = current_user.posts.find(params[:id])
    if @post.user != current_user
      redirect_to root_path, alert: "アクセス権がありません"
    end
  end
end
