class LikesController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]

  def create
    @item = Item.find(params[:item_id])
    @like = current_user.likes.create(item_id: params[:item_id])
  end

  def destroy
    @item = Item.find(params[:item_id])
    @like = Like.find_by(item_id: params[:item_id], user_id: current_user.id)
    @like.destroy
  end
end
