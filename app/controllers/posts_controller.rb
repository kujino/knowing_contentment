class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :post_authorize, only: [ :edit, :update, :destroy ]
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]

  def index
    @posts = Post.includes(:user, :theme, image_attachment: :blob).order(created_at: :desc)
  end

  def new
    if current_user.posts.where(created_at: Time.current.all_day).exists?
      redirect_to request.referrer || root_path, notice: t("flash_messages.notice.posts_are_made_once_a_day")
    else
      @post = Post.new
      @today_theme = Theme.order("RANDOM()").first
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    @today_theme = Theme.find(params[:post][:theme_id])
    if @post.save
      redirect_to post_path(@post), notice: t("flash_messages.notice.create")
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
      redirect_to post_path(@post), notice: t("flash_messages.notice.edit")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post
    @post.destroy!
    redirect_to mypage_path, notice: t("flash_messages.notice.delete")
  end

  def mine
     @posts = current_user.posts.includes(:theme, image_attachment: :blob).order(created_at: :desc)
  end

  private

  def post_params
    params.require(:post).permit(:content, :is_anonymous, :theme_id, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  # 投稿ユーザー以外アクセス不可
  def post_authorize
    if @post.user != current_user
      redirect_to root_path, alert: t("flash_messages.notice.access_denied")
    end
  end
end
