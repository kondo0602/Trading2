require 'test_helper'

class ItemTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @item = items(:orange)
  end

  test "should be valid" do
    assert @item.valid?
  end

  #itemの並び順に対するテスト

  test "order should be most recent first" do
    assert_equal items(:most_recent), Item.first
  end

  test "name should be present" do
    @item.name = "   "
    assert_not @item.valid?
  end

  test "content should be present" do
    @item.content = "   "
    assert_not @item.valid?
  end

  test "brand should be present" do
    @item.brand = "   "
    assert_not @item.valid?
  end

  test "size should be present" do
    @item.size = "   "
    assert_not @item.valid?
  end

  test "status should be present" do
    @item.status = "   "
    assert_not @item.valid?
  end

  test "user id should be present" do
    @item.user_id = nil
    assert_not @item.valid?
  end
end
