class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    redirect_to post_path(comment.post.id)
  end

  def destroy
    @post = Post.find(params[:post_id])
    comment = @post.comments.find(params[:id])
    comment.destroy
    redirect_to post_path(@post)
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :image).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
