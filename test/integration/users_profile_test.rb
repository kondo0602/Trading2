require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "mypage display with login" do
    log_in_as(@user)
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'img.gravatar'
    assert_select 'p', text: @user.name
    assert_select "a[href=?]", shitagaki_path
    assert_select "a[href=?]", new_item_path
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", rooms_path
    assert_match @user.items.count.to_s, response.body
    assert_select 'div.pagination',count: 2
  end

  test "other userpage display with login" do
    log_in_as(@user)
    get user_path(@other_user)
    assert_template 'users/show'
    assert_select 'title', full_title(@other_user.name)
    assert_select 'img.gravatar'
    assert_select 'p', text: @other_user.name
    assert_match @other_user.items.count.to_s, response.body
  end

  test " userpage display with not login" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'img.gravatar'
    assert_select 'p', text: @user.name
    assert_match @user.items.count.to_s, response.body
  end
end
