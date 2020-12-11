ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
#minitestの結果に着色する
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # 特定のワーカーではテストをパラレル実行する
  parallelize(workers: :number_of_processors)

  #applicationhelperに記載されているメソッド（full_title）をテストの中で使用できるようにする
  include ApplicationHelper
  # すべてのテストがアルファベット順に実行されるよう、
  #test/fixtures/*.ymlにあるすべてのfixtureをセットアップする
  fixtures :all

  # テストユーザーがログイン中の場合にtrueを返す
  #sessionsHelperに記載しているlogged_in?メソッドはテストからは呼び出せないため新規作成
  def is_logged_in?
    !session[:user_id].nil?
  end

  # テストユーザーとしてログインする
  def log_in_as(user)
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id:session[:user_id])
    end
  end
end

class ActionDispatch::IntegrationTest

  # テストユーザーとしてログインする
  def log_in_as(user, password: 'password')
    post login_path, params: { session: { email: user.email,
                                          password: password } }
  end
end
