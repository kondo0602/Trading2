require 'rails_helper'

describe 'ユーザ管理機能', type: :system do
  let(:user_a) {create(:user)}
  let(:user_b) {create(:user)}
  let!(:item) {create(:item, user: user_a)}

  describe 'ユーザ新規作成機能' do
    before do
      visit new_user_path
      fill_in "user[name]", with: 'test'
      fill_in "user[email]", with: 'a@example.com'
      fill_in "user[password]", with: 'password'
      fill_in "user[password_confirmation]", with: 'password'
    end

    context '必要な情報が全て入力されている場合' do
      it '登録したユーザのユーザ詳細ページに遷移し、適切なfalshが表示されていること' do
        click_on 'ユーザ登録'
        #ログインしているかどうかのテストも必要か
        expect(current_path).to eq user_path(User.find_by(email: 'a@example.com'))
        expect(page).to have_content 'Welcome to Trading!'
      end
    end

    context '名前が入力されていない場合' do
      it 'ユーザ登録ページにリダイレクトされ、適切なflashが表示されること' do
        fill_in "user[name]", with: ''
        click_on 'ユーザ登録'
        expect(current_path).to eq users_path
        expect(page).to have_content "Name can't be blank"
      end
    end

    context 'メールアドレスが入力されていない場合' do
      it 'ユーザ登録ページにリダイレクトされ、適切なflashが表示されること' do
        fill_in "user[email]", with: ''
        click_on 'ユーザ登録'
        expect(current_path).to eq users_path
        expect(page).to have_content "Email can't be blank"
      end
    end

    context 'パスワードが入力されていない場合' do
      it 'ユーザ登録ページにリダイレクトされ、適切なflashが表示されること' do
        fill_in "user[password]", with: ''
        click_on 'ユーザ登録'
        expect(current_path).to eq users_path
        expect(page).to have_content "Password can't be blank"
      end
    end

    context 'パスワード再確認が入力されていない場合' do
      it 'ユーザ登録ページにリダイレクトされ、適切なflashが表示されること' do
        fill_in "user[password_confirmation]", with: ''
        click_on 'ユーザ登録'
        expect(current_path).to eq users_path
        expect(page).to have_content "Password confirmation doesn't match Password"
      end
    end
  end

  describe 'ユーザ詳細画面表示機能' do
    before do
      visit login_path
      fill_in "session[email]", with: login_user.email
      fill_in "session[password]", with: 'password'
      click_on 'ログインする'
    end

    context 'ユーザがログインしている場合' do
      let(:login_user) { user_a }

      it 'ログインユーザにしか使用できない機能のリンクが表示されること' do
        visit user_path(user_a)
        expect(page).to have_content 'いいねした商品一覧'
        expect(page).to have_content '下書き一覧'
        expect(page).to have_content '出品する'
        expect(page).to have_content 'ユーザ情報の編集'
        expect(page).to have_content 'DM一覧'
        expect(page).to have_content item.name
      end
    end

    context '自分以外のユーザがログインしている場合' do
      let(:login_user) { user_b }

      it 'ログインユーザにしか使用できない機能のリンクが表示されないこと' do
        visit user_path(user_a)
        expect(page).not_to have_content 'いいねした商品一覧'
        expect(page).not_to have_content '下書き一覧'
        expect(page).not_to have_content '出品する'
        expect(page).not_to have_content 'ユーザ情報の編集'
        expect(page).not_to have_content 'DM一覧'
      end
    end
  end
end
