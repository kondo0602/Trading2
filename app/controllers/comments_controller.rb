class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def create
    @comment = current_user.comments.build(comment_params)

    if @comment.save
      redirect_back(fallback_location: root_path)
      flash[:success] = 'コメントを投稿しました'
    else
      redirect_back(fallback_location: root_path)
      flash[:danger] = 'コメントの投稿に失敗しました'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :item_id)
  end
end
