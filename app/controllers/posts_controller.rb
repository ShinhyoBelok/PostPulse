class PostsController < ApplicationController
  def index
    @user = User.includes(posts: :comments).find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.author = current_user
    @post.comments_counter = 0
    @post.likes_counter = 0

    return unless @post.save

    redirect_to "/users/#{current_user.id}/posts"
  end

  def destroy
    @user = current_user
    @post = Post.find(params[:id])
    authorize! :destroy, @post
    @post.destroy
    redirect_to user_posts_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
