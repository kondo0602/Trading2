require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
    @item = items(:orange)
  end

  test "should get index" do
    get items_path
    assert_response :success
  end

  test "should get create" do
    log_in_as(@user)
    assert_difference 'Item.count', +1 do
    post items_path, params: { item: { name: "Sample",
                                       content: "Sample",
                                       brand: "Sample",
                                       size: "26cm",
                                       status: "新品未使用" } }
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should get new" do
    log_in_as(@user)
    get new_item_path
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@user)
    get edit_item_path(@item)
    assert_response :success
  end

  test "should get show" do
    get item_path(@item)
    assert_response :success
  end

  test "should get update" do
    log_in_as(@user)
    assert_no_difference 'Item.count' do
    patch item_path(@item), params: { item: { name: "Sample",
                                       content: "Sample",
                                       brand: "Sample",
                                       size: "26cm",
                                       status: "新品未使用" } }
    end
    assert_not flash.empty?
    assert_redirected_to item_url(@item)
  end

  test "should get destroy" do
    log_in_as(@user)
    assert_difference 'Item.count', -1 do
      delete item_path(@item)
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Item.count' do
      post items_path, params: { item: { name: "name",
                                        content: "content" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect new when not logged in" do
    get new_item_path
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Item.count' do
      delete item_path(@item)
    end
    assert_redirected_to login_url
  end

  test "should redirect edit item when wrong user" do
    log_in_as(@other_user)
    get edit_item_path(@item)
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update item when wrong user" do
    log_in_as(@other_user)
    get edit_item_path(@item), params: { item: { name: "patch item", } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end
end
