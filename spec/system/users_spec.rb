require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # indexページに遷移する
      visit root_path
      # ヘッダーに新規登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'ユーザーネーム', with: @user.name
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード（6文字以上）', with: @user.password
      fill_in 'パスワード（確認用）', with: @user.password_confirmation
      # Sign upボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # topページへ遷移したことを確認する
      expect(current_path).to eq pages_top_path
      # ヘッダーにログアウトボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')
      # 新規登録ページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # indexページに遷移する
      visit root_path
      # indexページに新規登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'ユーザーネーム', with: ""
      fill_in 'メールアドレス', with: ""
      fill_in 'パスワード（6文字以上）', with: ""
      fill_in 'パスワード（確認用）', with: ""
      # Sign upボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq "/users"
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # indexページに遷移する
      visit root_path
      # indexページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      # Log inボタンを押す
      find('input[name="commit"]').click
      # topページへ遷移することを確認する
      expect(current_path).to eq pages_top_path
      # ヘッダーにログアウトボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # indexページに遷移する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'メールアドレス', with: ""
      fill_in 'パスワード', with: ""
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe 'ゲストユーザーログイン', type: :system do
  context 'ログインができるとき' do
    it 'ゲストログインボタンを押すとゲストログインする' do
      #indexページに遷移する
      visit root_path
      #indexページにゲストログインできるボタンがあることを確認する
      expect(page).to have_content('ゲストログイン（閲覧用）')
      # ゲストログイン（閲覧用）ボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('a[rel="nofollow"]').click
      }.to change { User.count }.by(1)
      # topページへ遷移することを確認する
      expect(current_path).to eq pages_top_path
      # ヘッダーにログアウトボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
end

RSpec.describe 'ユーザー情報編集', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end
  context 'ユーザー情報を変更できるとき' do
    it 'ログインしたユーザーは自分の情報を変更できる' do
      # @user1でログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user1.email
      fill_in 'パスワード', with: @user1.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # ヘッダーに「こんにちは、'@user1の名前'さん」が表示されていることを確認する
      expect(page).to have_content("こんにちは、#{@user1.name}さん")
      # @user1のマイページに遷移する
      visit page_path(@user1)
      # 編集ボタンが表示されていることを確認する
      expect(page).to have_content('編集')
      # 編集画面に遷移する
      visit edit_page_path(@user1)
      # ユーザー情報を編集する
      attach_file "user[image]", 'app/assets/images/test_image.png'
      fill_in 'プロフィール', with: "text"
      # 編集してもUserモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # マイページに遷移したことを確認する
      expect(current_path).to eq page_path(@user1)
      # マイページには変更した内容の情報がある事を確認する(画像)
      expect(page).to have_selector("img[src$='test_image.png']")
      # マイページには変更した内容の情報がある事を確認する(プロフィール文)
      expect(page).to have_content("text")
    end
  end
  context 'ユーザー情報を変更できないとき' do
    it 'ログインしたユーザーは自分以外の詳細画面では編集ボタンが表示されない' do
      # @user2でログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user2.email
      fill_in 'パスワード', with: @user2.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # ヘッダーに「こんにちは、'@user2の名前'さん」が表示されていることを確認する
      expect(page).to have_content("こんにちは、#{@user2.name}さん")
      # @user1のマイページに遷移する
      visit page_path(@user1)
      # 編集ボタンが表示されていないことを確認する
      expect(page).to have_no_content('編集')
    end
    it 'ログインしたユーザーは自分以外の編集画面に遷移できない' do
      # @user2でログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user2.email
      fill_in 'パスワード', with: @user2.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # ヘッダーに「こんにちは、'@user2の名前'さん」が表示されていることを確認する
      expect(page).to have_content("こんにちは、#{@user2.name}さん")
      # @user1の編集画面に遷移しようとする
      visit edit_page_path(@user1)
      # topページへ遷移することを確認する
      expect(current_path).to eq pages_top_path
    end
    it 'ログインしていないとユーザー情報の編集画面には遷移できない' do
      # indexページに遷移する
      visit root_path
      # @user1の編集画面に遷移しようとする
      visit edit_page_path(@user1)
      # ログイン画面に遷移した事を確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end
