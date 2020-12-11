require 'test_helper'

class LikeTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @item = items(:orange)
    @like = likes(:one)
  end

  test "like be valid" do
    assert @like.valid?
  end

  test "like should be one" do
    @like.save
    duplicate_like = @like.dup
    assert_not duplicate_like.valid?
  end

  test "associated likes should be destroyed" do
    @user.save
    @like.save
    assert_difference 'Like.count', -1 do
      @user.destroy
    end
  end
end
