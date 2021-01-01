require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    # association使って描き直したい・・・うまくいかないので保留
    @user = create(:user)
    @item = build(:item, user_id: @user.id)
    @item.image.attach(io: File.open('app/assets/images/item1.jpg'), filename: 'item1.jpg')
    @item.save!
    @comment = build(:comment, content: 'content',
                               user_id: @user.id,
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
