require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should get show" do
    get user_path(@user)
    assert_response :success
  end

  test "should get create with valid user" do
    get new_user_path
    assert_response :success
    assert_difference 'User.count', +1 do
    post users_path, params: { user: { name: "Example User",
                                       email: "user@example.com",
                                       password: "foobar",
                                       password_comfirmation: "foobar"} }
    end
    assert_not flash.empty?
    assert is_logged_in?
  end

  test "should get create with invalid user" do
    get new_user_path
    assert_response :success
    assert_no_difference 'User.count' do
    post users_path, params: { user: { name: " ",
                                       email: " ",
                                       password: " ",
                                       password_comfirmation: " "} }
    end
    assert flash.empty?
    assert_not is_logged_in?
    assert_template 'users/new'
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@user)
    get edit_user_path(@other_user)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@user)
    patch user_path(@other_user), params: { user: { name: @other_user.name,
                                              email: @other_user.email } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
                                    user: { password:              "password",
                                            password_confirmation: "password",
                                            admin: true } }
    assert_not @other_user.reload.admin?
  end

  test "should riderect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should riderect destroy when login as non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end
end
