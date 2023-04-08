class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.author = current_user
    @comment.post = @post

    return unless @comment.save

    @post.update_comment_counter
    redirect_to "/users/#{current_user.id}/posts/#{@post.id}"
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
