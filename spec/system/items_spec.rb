require 'rails_helper'

RSpec.describe '商品管理機能', type: :system do
  before do
    @user = create(:user)
    @item = create(:item, user_id: @user.id)
    @item2 = create(:item, user_id: @user.id)
  end

  describe '商品一覧画面表示機能' do
    it '商品一覧画面が表示される' do
      visit items_path
      expect(page).to have_content @item.name
      expect(page).to have_content @item2.name
    end
  end
end
