require 'rails_helper'

RSpec.describe '商品管理機能', type: :system do
  before do
    @user = create(:user)
    @item = build(:item, user_id: @user.id)
    @item.image = fixture_file_upload('app/assets/images/header.jpeg')
    @item.save
  end

  describe '商品一覧画面表示機能' do
    it '商品一覧画面が表示される' do
      visit items_path
      expect(page).to have_content @item.name
    end
  end
end
