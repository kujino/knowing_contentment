class MypagesController < ApplicationController
  def show
    @user = current_user
    @posts = current_user.posts.includes(:theme, image_attachment: :blob).order(created_at: :desc).limit(5)
    @calendar_posts = current_user.posts
  end
end
