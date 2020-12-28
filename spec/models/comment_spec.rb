require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    # association使って描き直したい・・・うまくいかないので保留
    @user = create(:user)
    @item = create(:item, user_id: @user.id)
    @comment = build(:comment, user_id: @user.id,
                               item_id: @item.id)
  end

  describe 'バリデーション' do
    it 'contentとuser_idとitem_idが設定されていればOK' do
      expect(@comment.valid?).to eq(true)
    end

    it 'contentが空白だとNG' do
      @comment.content = ''
      expect(@comment.valid?).to eq(false)
    end

    it 'contentが255文字より長いとNG' do
      @comment.content = 'a' * 256
      expect(@comment.valid?).to eq(false)
    end
  end
end
