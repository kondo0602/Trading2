class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def create
    @comment = current_user.comments.build(comment_params)
    @comments = Comment.where(item_id: params[:item_id]) if @comment.save
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :item_id)
  end
end
