class Api::PostsController < ApplicationController
  def api_index
    user = User.includes(posts: :comments).find(params[:user_id])
    posts = user.posts.includes(:comments)
    render json: posts
  end
end
