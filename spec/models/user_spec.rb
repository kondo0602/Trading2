require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
    sleep 1.0
  end

  describe 'バリデーション' do
    it 'name/email/passwordに値が設定されていればOK' do
      expect(@user.valid?).to eq(true)
    end

    it 'nameが空白だとNG' do
      @user.name = ''
      expect(@user.valid?).to eq(false)
    end

    it 'nameが50文字より長いとNG' do
      @user.name = 'a' * 51
      expect(@user.valid?).to eq(false)
    end

    it 'emailが空白だとNG' do
      @user.email = ''
      expect(@user.valid?).to eq(false)
    end

    it 'emailが255文字より長いとNG' do
      @user.email = "#{'a' * 244}@example.com"
      expect(@user.valid?).to eq(false)
    end

    it 'emailが既に使用されているものであるとNG' do
      @user.save
      duplicate_user = @user.dup
      expect(duplicate_user.valid?).to eq(false)
    end

    it 'emailがDBに小文字で格納されているか' do
      @user.email = 'Foo@ExAMPle.CoM'
      @user.save
      expect(@user.email.downcase).to eq(@user.reload.email)
    end

    it 'addressが空白だとNG' do
      @user.address = ''
      expect(@user.valid?).to eq(false)
    end

    it 'passwordが6文字より短いとNG' do
      @user.password = '55555'
      expect(@user.valid?).to eq(false)
    end
  end

  describe 'アソシエーション' do
    before do
      @user.save
      @item = build(:item, user_id: @user.id)
      @item.image.attach(io: File.open('app/assets/images/item1.jpg'), filename: 'item1.jpg')
      @item.save
      @user_b = create(:user)
      @room = Room.create
      @entry_a = Entry.create(room_id: @room.id, user_id: @user.id)
      @entry_b = Entry.create(room_id: @room.id, user_id: @user_b.id)
    end

    it 'userが削除されたらuserが出品しているitemも削除されること' do
      expect { @user.destroy }.to change { Item.count }.by(-1)
    end

    it 'userが削除されたらuserが参加しているentryも削除されること' do
      expect { @user.destroy }.to change { Entry.count }.by(-1)
    end

    it 'userが削除されたらuserが送信したdmも削除されること' do
      @dm = create(:dm, room_id: @room.id, user_id: @user.id)
      expect { @user.destroy }.to change { Dm.count }.by(-1)
    end
  end
end
