require 'rails_helper'

describe 'コメント管理機能', type: :system do
  before do
    @user = build(:user)
    @user.image = fixture_file_upload('/files/user.jpg')
    @user.save!
    @item = build(:item, user_id: @user.id)
    @item.image = fixture_file_upload('/files/item1.jpg')
    @item.save!
  end

  describe 'コメント新規作成機能' do
    before do
      # ログインする
      visit login_path
      fill_in 'session[email]', with: @user.email
      fill_in 'session[password]', with: 'password'
      click_on 'ログインする'
    end

    context 'コメントが入力されている場合' do
      it '商品詳細ページにリダイレクトされ、適切なflashが表示されていること' do
        visit item_path(@item)
        fill_in 'comment[content]', with: 'コメントです。'
        click_on 'コメントする'
        expect(current_path).to eq item_path(@item)
        expect(page).to have_content 'コメントを投稿しました'
      end
    end

    context 'コメントが入力されていない場合' do
      it '商品詳細ページにリダイレクトされ、適切なflashが表示されていること' do
        visit item_path(@item)
        fill_in 'comment[content]', with: ''
        click_on 'コメントする'
        expect(current_path).to eq item_path(@item)
        expect(page).to have_content 'コメントの投稿に失敗しました'
      end
    end
  end
end
