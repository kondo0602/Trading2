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
      select '宮城県', from: 'user[address]'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_on 'ユーザ登録'
      visit item_path(item)
    end

    context 'コメントが入力されている場合' do
      it '商品詳細ページにリダイレクトされ、適切なflashが表示されていること' do
        fill_in 'comment[content]', with: 'コメントです。'
        click_on 'コメントする'
        expect(current_path).to eq item_path(item)
        expect(page).to have_content 'コメントを投稿しました'
      end
    end
  end
end
