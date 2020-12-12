require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    #association使って描き直したい・・・うまくいかないので保留
    @user = create(:user)
    @item = build(:item, user_id: @user.id)
  end

  describe 'バリデーション' do
    it '必須項目に値が設定されていればOK' do
      expect(@item.valid?).to eq(true)
    end

    it 'nameが空白だとNG' do
      @item.name = ''
      expect(@item.valid?).to eq(false)
    end

    it 'nameが50文字より長いとNG' do
      @item.name = "a" * 51
      expect(@item.valid?).to eq(false)
    end

    it 'contentが空白だとNG' do
      @item.content = ''
      expect(@item.valid?).to eq(false)
    end

    it 'contentが255文字より長いとNG' do
      @item.content = "a" * 256
      expect(@item.valid?).to eq(false)
    end

    it 'brandが空白だとNG' do
      @item.brand = ''
      expect(@item.valid?).to eq(false)
    end

    it 'sizeが空白だとNG' do
      @item.size = ''
      expect(@item.valid?).to eq(false)
    end

    it 'statusが空白だとNG' do
      @item.status = ''
      expect(@item.valid?).to eq(false)
    end

    it 'user_idが空白だとNG' do
      @item.user_id = ''
      expect(@item.valid?).to eq(false)
    end
  end

  describe 'アソシエーション' do
    it 'itemが削除されたらitemに紐づくlikeも削除されること' do
      @item.save
      @item.likes.create!(user_id: @user.id)
      expect{ @item.destroy }.to change{ Like.count }.by(-1)
    end

    it 'itemが削除されたらitemに紐づくcommentも削除されること' do
      @item.save
      @item.comments.create!(content: "a", user_id: @user.id)
      expect{ @item.destroy }.to change{ Comment.count }.by(-1)
    end
  end
end