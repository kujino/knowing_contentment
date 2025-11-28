class ReactionsController < ApplicationController
  before_action :set_post

  def create
    current_user.reaction(@post)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: @post }
    end
  end

  def destroy
    current_user.unreaction(@post)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: @post }
    end
  end

  private

  def set_post
    if params[:post_id]
      @post = Post.find(params[:post_id])
    else
      @post = current_user.reactions.find(params[:id]).post
    end
  end
end
