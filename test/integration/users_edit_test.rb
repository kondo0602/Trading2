require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "successful edit do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    assert flash.empty?
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
    get root_path
    assert_not flash.empty?
  end

  test "failed edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }
    assert_template 'users/edit'
    assert_select "div", "The form contains 4 errors."
  end
end
