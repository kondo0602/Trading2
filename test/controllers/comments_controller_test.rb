require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
    @item = items(:orange)
  end

  test "should get create comment" do
    log_in_as(@user)
    assert_difference 'Comment.count', +1 do
      post item_comments_path(@item), params: { comment: { content: "Sample",
                                                           user_id: @user.id,
                                                           item_id: @item.id} }
    end
    assert_not flash.empty?
  end

  test "should redirect comment when not logged in" do
    assert_no_difference 'Comment.count' do
      post item_comments_path(@item), params: { comment: { content: "Sample",
                                                           user_id: @user.id,
                                                           item_id: @item.id} }
    end
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
