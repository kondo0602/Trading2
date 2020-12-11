#ユーザモデルの単体テスト
require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
  end

  test "should be valid" do
    assert @user.valid?
  end

  #user.nameのバリデーションに対するテスト

  test "name should be present" do
  @user.name = "     "
  assert_not @user.valid?
  end

  test "name should not be too long" do
  @user.name = "a" * 51
  assert_not @user.valid?
  end

  #user.emailのバリデーションに対するテスト

  test "email should be present" do
  @user.email = "     "
  assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    # %wで指定した文字列が入った配列を作成する
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
   invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                          foo@bar_baz...com foo@bar+baz.com]
   invalid_addresses.each do |invalid_address|
     @user.email = invalid_address
     assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
   end
 end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
  mixed_case_email = "Foo@ExAMPle.CoM"
  @user.email = mixed_case_email
  @user.save
  assert_equal mixed_case_email.downcase, @user.reload.email
  end

  #user.passwordのバリデーションに対するテスト

  test "password should be present" do
  @user.password = @user.password_confirmation = " " * 6
  assert_not @user.valid?
  end

  test "password should not be too short" do
  @user.password = @user.password_confirmation = "a" * 5
  assert_not @user.valid?
  end

  #userが削除されたときに対応するオブジェクトが削除されることを確認するテスト

  test "associated items should be destroyed" do
    @user.save
    @user.items.create!(name: "blundstone", content: "Black Shoes",
                        brand: "nike", size: "27cm", status: "新品未使用")
    assert_difference 'Item.count', -35 do
      @user.destroy
    end
  end
end
