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

  describe '商品投稿機能' do
    before do
      visit login_path
      fill_in 'session[email]', with: @user.email
      fill_in 'session[password]', with: 'password'
      click_on 'ログインする'
    end

    it '商品投稿ページに遷移できること' do
      visit new_item_path
      expect(current_path).to eq new_item_path
    end

    context '必要な情報が全て入力されている場合' do
      it '商品情報を投稿し、商品一覧ページに遷移し、適切なflashが表示されていること' do
        visit new_item_path
        attach_file 'item[image]', 'app/assets/images/item1.jpg'
        fill_in 'item[name]', with: 'name'
        fill_in 'item[content]', with: 'content'
        fill_in 'item[brand]', with: 'brand'
        select '25cm', from: 'item[size]'
        select '未使用新品', from: 'item[status]'
        click_on '出品する'
        expect(current_path).to eq items_path
        expect(page).to have_content '出品しました！'
      end
    end
  end

  describe '商品編集機能' do
    before do
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

    context '必要な情報が全て入力されている場合' do
      it '商品情報を編集し、商品詳細ページに遷移し、適切なflashが表示されていること' do
        visit edit_item_path(@item)
        click_on '編集内容を確定する'
        expect(current_path).to eq item_path(@item)
        expect(page).to have_content '商品情報の編集が完了しました'
      end
    end

    context '商品名が入力されていない場合' do
      it '商品情報編集ページにリダイレクトされ、適切なflashが表示されていること' do
        visit edit_item_path(@item)
        fill_in 'item[name]', with: ''
        click_on '編集内容を確定する'
        expect(current_path).to eq item_path(@item)
        expect(page).to have_content '商品名を入力してください'
      end
    end

    context '商品説明が入力されていない場合' do
      it '商品情報編集ページにリダイレクトされ、適切なflashが表示されていること' do
        visit edit_item_path(@item)
        fill_in 'item[content]', with: ''
        click_on '編集内容を確定する'
        expect(current_path).to eq item_path(@item)
        expect(page).to have_content '商品の説明を入力してください'
      end
    end

    context '商品のブランドが入力されていない場合' do
      it '商品情報編集ページにリダイレクトされ、適切なflashが表示されていること' do
        visit edit_item_path(@item)
        fill_in 'item[brand]', with: ''
        click_on '編集内容を確定する'
        expect(current_path).to eq item_path(@item)
        expect(page).to have_content 'ブランド名を入力してください'
      end
    end

    context '商品のサイズが入力されていない場合' do
      it '商品情報編集ページにリダイレクトされ、適切なflashが表示されていること' do
        visit edit_item_path(@item)
        select 'サイズを選択して下さい', from: 'item[size]'
        click_on '編集内容を確定する'
        expect(current_path).to eq item_path(@item)
        expect(page).to have_content 'サイズを入力してください'
      end
    end

    context '商品の状態が入力されていない場合' do
      it '商品情報編集ページにリダイレクトされ、適切なflashが表示されていること' do
        visit edit_item_path(@item)
        select '商品の状態を選択して下さい', from: 'item[status]'
        click_on '編集内容を確定する'
        expect(current_path).to eq item_path(@item)
        expect(page).to have_content '商品の状態を入力してください'
      end
    end
  end
end
