class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[edit update destroy]
  before_action :correct_user, only: %i[edit update]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @items = Item.where(user_id: @user.id)
                 .where(shitagaki: '0')
                 .paginate(page: params[:page])
    if logged_in?
      # 今操作しているユーザ
      @currentUserEntry = Entry.where(user_id: current_user.id)
      # 詳細ページの持ち主であるユーザ
      @userEntry = Entry.where(user_id: @user.id)
      @isRoom == false
      # 操作しているユーザ自身のユーザ詳細ページである場合、ルームがあるかどうかの判定だけ行う
      if @user.id == current_user.id
        @isRoom = true if @currentUserEntry
      # 操作しているユーザ以外のユーザ詳細ページであればメッセージを送るための情報を渡す
      else
        @currentUserEntry.each do |cu|
          @userEntry.each do |u|
            # 操作しているユーザとそのページの持ち主のユーザのルームがあれば
            if cu.room_id == u.room_id
              @isRoom = true
              @roomId = cu.room_id
            end
          end
        end
        if @isRoom
        # まだその二人の間にルームがなければ空のルームとエントリを作成する
        else
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Tradingへようこそ!'
      login @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'ユーザ情報の編集が完了しました'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'ユーザ情報の削��が完了しました'
    redirect_to root_path
  end

  private

  # strong parametersを使用するための外部メソッド
  def user_params
    params.require(:user).permit(:image, :name, :email, :address, :password,
                                 :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      flash[:danger] = 'そのページに対する編集権限がありません'
      redirect_to root_url
    end
  end
end
