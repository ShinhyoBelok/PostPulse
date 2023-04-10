class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = Like.new(author: current_user, post: @post)
    return unless @like.save

    redirect_back(fallback_location: root_path)
  end
end
