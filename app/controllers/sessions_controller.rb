class SessionsController < ApplicationController
  def new; end

  def create
    # find_byで見つからない場合nilを返す
    # findメソッドの場合、ユーザが見つからないと例外が発生してしまう
    user = User.find_by(email: params[:session][:email].downcase)
    # ユーザがいなければnilを返す
    # ユーザがいるなら認証（user.authenticate）を行う
    # if user && user.authenticate(params[:session][:password])と等価である
    if user&.authenticate(params[:session][:password])
      login user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
