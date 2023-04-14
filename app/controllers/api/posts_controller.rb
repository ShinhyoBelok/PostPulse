class Api::PostsController < Api::ApplicationController
  def api_index
    if (user = User.includes(posts: :comments).find_by(id: params[:user_id]))
      posts = user.posts.includes(:comments)
    end

    if user
      if posts
        render json: posts
      else
        render json: { error: 'No posts found', status: 404 }
      end
    else
      render json: { error: 'No user found', status: 404 }
    end
  end
end
