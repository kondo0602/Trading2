class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @items = Item.where(user_id: @user.id)
                 .where(shitagaki: '0')
                 .paginate(page: params[:page])
    if logged_in?
      # 今操作しているユーザのエントリがあるか
      @current_user_entry = Entry.where(user_id: current_user.id)
      # 詳細ページの持ち主であるユーザのエントリがあるか
      @user_entry = Entry.where(user_id: @user.id)
      # Roomがあるかどうかの判定を行う変数に初期値を入れる
      @is_room == false
      # 操作しているユーザ自身のユーザ詳細ページである場合
      if @user.id == current_user.id
        # ユーザのエントリが既にあればisRoomにtrueを入れる
        @is_room = true if @current_user_entry
      # 操作しているユーザ以外のユーザ詳細ページであればメッセージを送るための情報を渡す
      else
        # 操作しているユーザとそのページの持ち主のユーザのエントリで同じRoomIdを持つものがあるかループで探す
        @current_user_entry.each do |cu|
          @user_entry.each do |u|
            if cu.room_id == u.room_id
              @is_room = true
              @room_id = cu.room_id
            end
          end
        end
        if @is_room
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
    # ユーザ画像が設定されていない場合、初期画像をプロフィール画像に設定する
    unless @user.image.attached?
      @user.image.attach(io: File.open('app/assets/images/profile.png'),
                         filename: 'item1.jpg')
    end
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
    flash[:success] = 'ユーザ情報の削除が完了しました'
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
