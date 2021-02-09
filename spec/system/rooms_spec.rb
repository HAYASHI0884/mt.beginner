require 'rails_helper'

RSpec.describe "ルーム作成", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @room = FactoryBot.build(:room)
  end

  context 'ルーム作成ができるとき'do
    it 'ログインしたユーザーはルーム作成できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # ルーム作成ページへのリンクがあることを確認する
      expect(page).to have_content('チャットルームの作成はこちら')
      # 新規投稿画面に移動する
      visit new_room_path
      # フォームに情報を入力する
      fill_in "チャットルーム名", with: @room.name
      select @user2.name , from: "チャットメンバー"
      # 送信するとRoomモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Room.count }.by(1)
      # トップページに遷移する事を確認する
      expect(current_path).to eq pages_top_path
      # トップページには先ほど作成したルームが存在することを確認する
      expect(page).to have_content(@room.name)
    end
  end

  context 'ルーム作成ができないとき'do
    it 'ログインしていないとルーム作成ページに遷移できない' do
      # indexページに遷移する
      visit root_path
      # ルーム作成ページに遷移しようとする
      visit new_room_path
      # ログイン画面に遷移した事を確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe "ルーム削除", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @admin = FactoryBot.create(:admin)
    @room = FactoryBot.create(:room)
  end
end

RSpec.describe "ルーム一覧", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @room = FactoryBot.create(:room)
    @room2 = FactoryBot.create(:room)
  end
end

RSpec.describe "ルーム管理ページ", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @admin = FactoryBot.create(:admin)
    @room = FactoryBot.create(:room)
    @room2 = FactoryBot.create(:room)
  end
end
