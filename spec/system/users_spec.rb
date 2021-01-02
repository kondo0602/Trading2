require 'rails_helper'

describe 'ユーザ管理機能', type: :system do
  let(:user_a) { create(:user) }
  let(:user_b) { create(:user) }
  # let!(:item) { build(:item, user: user_a) }

  describe 'ユーザ新規作成機能' do
    before do
      visit new_user_path
      fill_in 'user[name]', with: 'test'
      fill_in 'user[email]', with: 'a@example.com'
      select '宮城県', from: 'user[address]'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
    end

    context '必要な情報が全て入力されている場合' do
      it '登録したユーザのユーザ詳細ページに遷移し、適切なflashが表示されていること' do
        click_on 'ユーザ情報登録'
        expect(current_path).to eq user_path(User.find_by(email: 'a@example.com'))
        expect(page).to have_content 'Tradingへようこそ!'
      end
    end

    context '名前が入力されていない場合' do
      it 'ユーザ情報登録ページにリダイレクトされ、適切なflashが表示されること' do
        fill_in 'user[name]', with: ''
        click_on 'ユーザ情報登録'
        expect(current_path).to eq users_path
        expect(page).to have_content 'ユーザ名を入力してください'
      end
    end

    context 'メールアドレスが入力されていない場合' do
      it 'ユーザ情報登録ページにリダイレクトされ、適切なflashが表示されること' do
        fill_in 'user[email]', with: ''
        click_on 'ユーザ情報登録'
        expect(current_path).to eq users_path
        expect(page).to have_content 'メールアドレスを入力してください'
      end
    end

    context '住んでいる県が選択されていない場合' do
      it 'ユーザ情報登録ページにリダイレクトされ、適切なflashが表示されること' do
        select 'お住まいの地域を選択してください', from: 'user[address]'
        click_on 'ユーザ情報登録'
        expect(current_path).to eq users_path
        expect(page).to have_content 'お住まいの地域を入力してください'
      end
    end

    context 'パスワードが入力されていない場合' do
      it 'ユーザ情報登録ページにリダイレクトされ、適切なflashが表示されること' do
        fill_in 'user[password]', with: ''
        click_on 'ユーザ情報登録'
        expect(current_path).to eq users_path
        expect(page).to have_content 'パスワードを入力してください'
      end
    end

    context 'パスワード再確認が入力されていない場合' do
      it 'ユーザ情報登録ページにリダイレクトされ、適切なflashが表示されること' do
        fill_in 'user[password_confirmation]', with: ''
        click_on 'ユーザ情報登録'
        expect(current_path).to eq users_path
        expect(page).to have_content '再入力されたパスワードとパスワードの入力が一致しません'
      end
    end
  end

  describe 'ユーザ詳細画面表示機能' do
    before do
      visit login_path
      fill_in 'session[email]', with: login_user.email
      fill_in 'session[password]', with: 'password'
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

  describe 'ユーザ情報編集機能' do
    before do
      visit login_path
      fill_in 'session[email]', with: user_a.email
      fill_in 'session[password]', with: 'password'
      click_on 'ログインする'
      visit edit_user_path(user_a)
      fill_in 'user[name]', with: 'edit_test'
      fill_in 'user[email]', with: 'a@example.com'
      select '宮城県', from: 'user[address]'
    end

    context '必要な情報が全て入力されている場合' do
      it 'ユーザ情報を編集し、ユーザ詳細ページにリダイレクトされること' do
        click_on 'ユーザ情報編集'
        expect(current_path).to eq user_path(user_a)
        expect(page).to have_content 'ユーザ情報の編集が完了しました'
      end
    end

    context '名前が入力されていない場合' do
      it 'ユーザ情報編集ページにリダイレクトされ、適切なflashが表示されること' do
        fill_in 'user[name]', with: ''
        click_on 'ユーザ情報編集'
        expect(current_path).to eq user_path(user_a)
        expect(page).to have_content '名前を入力してください'
      end
    end

    context 'メールアドレスが入力されていない場合' do
      it 'ユーザ情報編集ページにリダイレクトされ、適��なflashが表示されること' do
        fill_in 'user[email]', with: ''
        click_on 'ユーザ情報編集'
        expect(current_path).to eq user_path(user_a)
        expect(page).to have_content 'メールアドレスを入力してください'
      end
    end

    context '住んでいる県が選択されていない場合' do
      it 'ユーザ情報編集ページにリダイレクトされ、適切なflashが表示されること' do
        select 'お住まいの地域を選択してください', from: 'user[address]'
        click_on 'ユーザ情報編集'
        expect(current_path).to eq user_path(user_a)
        expect(page).to have_content 'お住まいの地域を入力してください'
      end
    end
  end
end
