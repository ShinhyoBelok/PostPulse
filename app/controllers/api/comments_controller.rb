class Api::CommentsController < Api::ApplicationController
  def api_index
    if (user = User.find_by(id: params[:user_id]))
      if (post = user.posts.find_by(id: params[:post_id]))
        if (comments = Comment.all.where(post:))
          render json: comments
        else
          render json: { error: 'No comments found', status: 404 }
        end
      else
        render json: { error: 'No post found', status: 404 }
      end
    else
      render json: { error: 'No user found', status: 404 }
    end
  end

  def api_create_comment
    if (@user = User.find_by(id: params[:user_id]))
      if (@post = Post.find_by(id: params[:post_id]))
        @comment = Comment.new(comment_params)
        @comment.post = @user.posts.find(params['post_id'])
        @comment.author = User.find_by(id: params[:author_id])

        if @comment.save
          render json: { status: :created, data: @comment }
        else
          render json: { error: @comment.errors, status: :unprocessable_entity }
        end
      else
        render json: { error: 'No post found', status: 404 }
      end
    else
      render json: { error: 'No user found', status: 404 }
    end
  end

  private

  def comment_params
    params.permit(:text)
  end
end
