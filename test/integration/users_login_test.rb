require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "login with valid information" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                         password: 'password' } }
    assert_redirected_to @user
    #follow_redirect!でHTTPリクエストの結果を見て、指定されたリダイレクト先に移動する
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", signup_path, count: 0
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", logout_path
    delete logout_path
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", user_path(@user), count: 0
    assert_select "a[href=?]", logout_path, count: 0
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    assert flash.empty?
    post login_path, params: { session: { email: "", password: "" } }
    #登録失敗、フラッシュにエラーメッセージが残る
    assert_template 'sessions/new'
    assert_not flash.empty?
    #他のページに移動したのでフラッシュが消える
    get root_path
    assert flash.empty?
  end

  test "login with valid email /invalid password" do
    get login_path
    assert_template 'sessions/new'
    assert flash.empty?
    post login_path, params: { session: { email:    @user.email,
                                         password: '' } }
    assert_not is_logged_in?
    #登録失敗、フラッシュにエラーメッセージが残る
    assert_template 'sessions/new'
    assert_not flash.empty?
  end
end
