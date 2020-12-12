module SessionsHelper

  # 渡されたユーザーでログインする
  def login(user)
    #ユーザのブラウザの一時cookieに暗号化したuser.idを保存する
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id:session[:user_id])
    end
  end

  def current_user?(user)
    user && user == current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
