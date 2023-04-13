class Api::CommentsController < ApplicationController
  def api_index
    post = Post.find(params[:post_id])
    comments = Comment.all.where(post:)
    render json: comments
  end

  def api_create_comment
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.author = current_user
    comment.post = post
    if comment.save
      render json: comment
    else
      render json: { error: 'Failed to create comment' }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
