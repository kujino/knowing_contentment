class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_post, only: [ :edit, :update, :destroy ]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user, :theme, image_attachment: :blob).order(created_at: :desc)
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
    @post = Post.find(params[:id])
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
    @q = current_user.posts.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:theme, image_attachment: :blob).order(created_at: :desc)
  end

  private

  def post_params
    params.require(:post).permit(:content, :is_anonymous, :theme_id, :image)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end

end
