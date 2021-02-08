require 'rails_helper'

RSpec.describe "山の検索", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @mountain = FactoryBot.create(:mountain)
    @mountain2 = FactoryBot.create(:mountain, name: "mountain_name2", area: FactoryBot.create(:area, name: "青森県"), elevation: FactoryBot.create(:elevation, name: "1000m以上、2000m未満"), climb_time: FactoryBot.create(:climb_time, name: "2時間以上、4時間未満"))
  end

  context '山の検索ができるとき' do
    it 'ログインしたユーザーは山の検索ができる' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # 山検索画面へのリンクがあることを確認する
      expect(page).to have_content('山の検索ページはこちら')
      # 山検索画面に移動する
      visit mountains_path
      # 山の情報が表示されていることを確認する
      expect(page).to have_content(@mountain.name)
      expect(page).to have_content(@mountain2.name)
      # フォームに情報を入力し、検索ボタンを押す
      fill_in '山の名前', with: "#{@mountain.name}"
      select '北海道', from: '地域'
      select '1000m未満', from: '標高'
      select '2時間未満', from: '総歩行時間'
      find('input[name="commit"]').click
      # 検索した条件以外の山が表示されていないことを確認する
      expect(page).to have_no_content(@mountain2.name)
      # 山の名前をクリックすると詳細ページに飛ぶことを確認する
      click_on @mountain.name
      expect(current_path).to eq mountain_path(@mountain)
      # 山の写真、地域、標高、総歩行時間が表示されていることを確認する
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@mountain.area.name)
      expect(page).to have_content(@mountain.elevation.name)
      expect(page).to have_content(@mountain.climb_time.name)
    end
  end

  context '山の検索ができないとき' do
    it 'ログインしていないユーザーは山の検索ができない' do
      # indexページに遷移する
      visit root_path
      # 投稿1の編集画面に遷移しようとする
      visit mountains_path
      # ログイン画面に遷移した事を確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe "山の投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @admin = FactoryBot.create(:admin)
    @mountain = FactoryBot.build(:mountain)
    @area = FactoryBot.create(:area)
    @elevation = FactoryBot.create(:elevation)
    @climb_time = FactoryBot.create(:climb_time)
  end

  context '山の投稿ができるとき' do
    it '管理者は山の投稿を行う事ができる' do
      # 管理者でログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @admin.email
      fill_in 'パスワード', with: @admin.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # 管理者ページに遷移する
      visit admin_mountains_path
      # 投稿画面に遷移する
      visit new_mountain_path
      # フォームに情報を入力する
      attach_file "mountain[image]", 'app/assets/images/test_image.png'
      fill_in '山の名前', with: @mountain.name
      select @area.name, from: "地域"
      select @elevation.name, from: "標高"
      select @climb_time.name, from: "総歩行時間"
      # 送信するとMountainモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Mountain.count }.by(1)
      # 管理者トップページに遷移することを確認する
      expect(current_path).to eq admin_mountains_path
      # 管理者トップページに先ほど投稿した山が存在することを確認する
      expect(page).to have_content(@mountain.name)
    end
  end

  context '山の投稿ができないとき' do
    it '管理者以外のユーザーは山の投稿画面に遷移できない' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # 管理者ページに遷移しようとする
      visit admin_mountains_path
      # topページへ遷移することを確認する
      expect(current_path).to eq pages_top_path
    end

    it 'ログインしていないユーザーは山の投稿画面に遷移できない' do
      # indexページに遷移する
      visit root_path
      # 管理者ページに遷移しようとする
      visit admin_mountains_path
      # ログイン画面に遷移した事を確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe "山の編集", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @admin = FactoryBot.create(:admin)
    @mountain = FactoryBot.create(:mountain)
  end

  context '山の編集ができるとき' do
    it '管理者は山の編集を行う事ができる' do

    end
  end

  context '山の編集ができないとき' do
    it '管理者以外のユーザーは山の編集画面に遷移できない' do

    end

    it 'ログインしていないユーザーは山の編集画面に遷移できない' do

    end
  end
end

RSpec.describe "山の削除", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @admin = FactoryBot.create(:admin)
    @mountain = FactoryBot.create(:mountain)
  end

  context '山の削除ができるとき' do
    it '管理者は山の削除を行う事ができる' do

    end
  end
end
