require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    # association使って描き直したい・・・うまくいかないので保留
    @user = create(:user)
    @item = build(:item, user_id: @user.id)
    @item.image.attach(io: File.open('app/assets/images/item1.jpg'), filename: 'item1.jpg')
    @item.save!
    @like = create(:like, user_id: @user.id,
                          item_id: @item.id)
    sleep 1.0
  end

  describe 'バリデーション' do
    it 'user_idとitem_idが設定されていればOK' do
      expect(@like.valid?).to eq(true)
    end

    it '同じユーザが同じ商品に一回しかいいねできない' do
      @like.save
      duplicate_like = @like.dup
      expect(duplicate_like.valid?).to eq(false)
    end
  end
end
