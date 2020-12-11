class LikesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @like = current_user.likes.create(item_id: params[:item_id])
    redirect_back(fallback_location: root_path)
    flash[:success] = "商品をお気に入りに追加しました"
  end

  def destroy
    @like = Like.find_by(item_id: params[:item_id], user_id: current_user.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
        flash[:success] = "商品をお気に入りから削除しました"
  end
end
