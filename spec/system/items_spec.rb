require 'rails_helper'

RSpec.describe '商品管理機能', type: :system do
  before do
    @user = create(:user)
    @item = build(:item, user_id: @user.id)
    @item.image.attach(io: File.open('app/assets/images/item1.jpg'), filename: 'item1.jpg')
    @item.save!
  end

  describe '商品一覧画面表示機能' do
    it '商品一覧画面が表示される' do
      visit items_path
      expect(page).to have_content @item.name
    end
  end

  describe '商品編集機能' do
    before do
      # ログインする
      visit login_path
      fill_in 'session[email]', with: @user.email
      fill_in 'session[password]', with: 'password'
      click_on 'ログインする'
    end

    it '商品編集ページに遷移できること' do
      visit item_path(@item)
      click_on 'この商品を編集する'
      expect(current_path).to eq edit_item_path(@item)
    end
  end
end
