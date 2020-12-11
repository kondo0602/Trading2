require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  #full_titleヘルパーメソッドのテスト
  test "full title helper" do
    assert_equal full_title,         "Trading"
    assert_equal full_title("Help"), "Help | Trading"
  end
end
