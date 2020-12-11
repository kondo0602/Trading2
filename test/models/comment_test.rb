require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @item = items(:orange)
    @comment = @user.comments.build(content: "content",
                                    item_id: @item.id)
  end

  test "comment be valid" do
    assert @comment.valid?
  end

  test "associated likes should be destroyed" do
    @user.save
    @item.save
    assert_difference 'Like.count', -1 do
      @user.destroy
    end
  end
end
