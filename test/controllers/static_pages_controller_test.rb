require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  #root/homeにアクセスできるかどうか
  test "should get root" do
    get root_path
    assert_response :success
  end

  #helpにアクセスできるかどうか
  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | Trading"
  end

  #aboutにアクセスできるかどうか
  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | Trading"
  end
end
