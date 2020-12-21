class ItemsController < ApplicationController
  before_action :logged_in_user, only: %i[create new destroy]
  before_action :correct_user, only: %i[edit update]

  def index
    @items = Item.where(shitagaki: '0').paginate(page: params[:page], per_page: 5)
  end

  def create
    @item = current_user.items.build(item_params)
    @item.image.attach(params[:item][:image])
    if @item.save
      flash[:success] = '出品しました!'
      redirect_to root_url
    else
      render 'items/new'
    end
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def show
    @item = Item.find(params[:id])
    @user = User.find(@item.user_id)
    @like = Like.new
    @comments = Comment.where(item_id: @item.id)
    @comment = current_user.comments.new if current_user
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = '商品情報の編集が完了しました'
      redirect_to @item
    else
      render 'edit'
    end
  end

  def destroy
    Item.find(params[:id]).destroy
    flash[:success] = '商品を削除しました'
    redirect_to root_url
  end

  def shitagaki
    @user = current_user
    @items = Item.where(shitagaki: '1').paginate(page: params[:page], per_page: 5)
  end

  def search
    @words = params[:search]
    if params[:or_search] == '1'
      split_keyword = params[:search].split(/[[:blank:]]+/)
      @items = []
      split_keyword.each do |keyword|
        next if keyword == ''

        @items += Item.where(['name LIKE ?', "%#{keyword}%"])
      end
      @items.uniq!
    else
      @items = Item.all.paginate(page: params[:page])
      if params[:search] != ''
        split_keyword = params[:search].split(/[[:blank:]]+/)
        split_keyword.each do |keyword|
          next if keyword == ''

          @items -= Item.where.not(['name LIKE ?', "%#{keyword}%"])
        end
      end
      @items -= Item.where.not(brand: params[:brand]) unless params[:brand] == ''
      @items -= Item.where.not(size: params[:size]) unless params[:size] == ''
      @items -= Item.where.not(status: params[:status]) unless params[:status] == ''
      # @size = params[:size]
    end
  end

  def likes
    @user = current_user
    @items = current_user.liked_items.includes(:user).paginate(page: params[:page], per_page: 5)
  end

  private

  def item_params
    params.require(:item).permit(:name, :content, :image,
                                 :shitagaki, :brand, :size, :status)
  end

  def correct_user
    @item = current_user.items.find_by(id: params[:id])
    if @item.nil?
      redirect_to root_url
      flash[:danger] = 'そのページに対する編集権限がありません'
    end
  end
end
