require 'rails_helper'

describe 'コメント管理機能', type: :system do
  let(:user_a) { create(:user) }
  let(:user_b) { create(:user) }
  let!(:item) { create(:item, user: user_a) }

  describe 'コメント新規作成機能' do
    before do
      visit new_user_path
      fill_in 'user[name]', with: 'test'
      fill_in 'user[email]', with: 'a@example.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
    end

    context '必要な情報が全て入力されている場合' do
      it '商品詳細ページに遷移できていること' do
        click_on 'ユーザ登録'
        visit item_path(item)
        expect(current_path).to eq item_path(item)
        # expect(page).to have_content 'Welcome to Trading!'
      end
    end
  end
end
