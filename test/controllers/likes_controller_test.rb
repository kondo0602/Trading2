require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
    @item = items(:orange)
    @like = likes(:one)
  end

  test "should get create" do
    log_in_as(@other_user)
    assert_difference 'Like.count', +1 do
      post item_likes_path(@item), params: { like: { item_id: @item.id,
                                                     user_id: @other_user.id } }
    end
    assert_not flash.empty?
  end

  test "should redirect create like when not logged in" do
    post item_likes_path(@item), params: { like: { item_id: @item.id,
                                                   user_id: @other_user.id } }
    assert_redirected_to login_url
  end
end
