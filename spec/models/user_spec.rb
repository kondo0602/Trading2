require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
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
      @user.email = 'a' * 244 + '@example.com'
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
    it 'userが削除されたらuserが出品しているitemも削除されること' do
      @user.save
      @user.items.create!(name: 'shoes', content: 'Black Shoes',
                          brand: 'nike', size: '27cm', status: '新品未使用')
      expect { @user.destroy }.to change { Item.count }.by(-1)
    end
  end
end
