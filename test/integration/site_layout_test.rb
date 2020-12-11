
require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links with login" do
    @user = users(:michael)
    log_in_as(@user)
    get root_path
    assert_template "items/index"
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", logout_path
    #フッター
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
  end

  test "layout links with not login" do
    get root_path
    assert_template root_path
    # ヘッダー
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", login_path
    # フッター
    get signup_path
    assert_select "a[href=?]", signup_path
  end
end
