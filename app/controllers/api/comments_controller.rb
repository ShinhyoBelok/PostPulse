class Api::CommentsController < Api::ApplicationController
  def api_index
    post = Post.find(params[:post_id])
    comments = Comment.all.where(post:)
    render json: comments
  end

  def api_create_comment
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.author = User.find(params[:author_id])
    @comment.post = @user.posts.find(params['post_id'])

    if @comment.save
      render json: { status: :created, data: @comment }
    else
      render json: { error: @comment.errors, status: :unprocessable_entity }
    end
  end

  private

  def comment_params
    params.permit(:text)
  end
end
