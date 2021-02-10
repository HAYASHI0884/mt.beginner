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

  context 'ルーム削除ができるとき' do
    it 'ルームの作成者であれば、ルームを削除できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @room.user.email
      fill_in 'パスワード', with: @room.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # topページにルームが存在することを確認する
      expect(page).to have_content(@room.name)
      # チャットルームに遷移する
      visit room_messages_path(@room)
      # 削除ボタンがあることを確認する
      expect(current_path).to eq room_messages_path(@room)
      expect(page).to have_content("チャットを終了する(ルームの削除)")
      # 削除ボタンを押して、confirmダイアログでOKを選択して、topページに移動するとレコードの数が1減ることを確認する
      expect{
        page.accept_confirm do
          find_link('チャットを終了する(ルームの削除)', href: room_path(@room)).click
        end
        expect(page).to have_content("こんにちは、#{@room.user.name}さん")
      }.to change { Room.count }.by(-1)
      # topページに遷移していることを確認する
      expect(current_path).to eq pages_top_path
      # topページにルームが存在しないことを確認する
      expect(page).to have_no_content(@room.name)
    end

    it '管理者であれば、ルームを削除できる' do
      # 管理者でログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @admin.email
      fill_in 'パスワード', with: @admin.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # topページにルームが存在することを確認する
      expect(page).to have_content(@room.name)
      # チャットルームに遷移する
      visit room_messages_path(@room)
      # 削除ボタンがあることを確認する
      expect(current_path).to eq room_messages_path(@room)
      expect(page).to have_content("チャットを終了する(ルームの削除)")
      # 削除ボタンを押して、confirmダイアログでOKを選択して、topページに移動するとレコードの数が1減ることを確認する
      expect{
        page.accept_confirm do
          find_link('チャットを終了する(ルームの削除)', href: room_path(@room)).click
        end
        expect(page).to have_content("こんにちは、#{@admin.name}さん")
      }.to change { Room.count }.by(-1)
      # topページに遷移していることを確認する
      expect(current_path).to eq pages_top_path
      # topページにルームが存在しないことを確認する
      expect(page).to have_no_content(@room.name)
    end

    it '管理者であればルーム一覧ページより、他者が作成したルームの削除ができる' do
      # 管理者でログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @admin.email
      fill_in 'パスワード', with: @admin.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # ルーム一覧ページに遷移する
      visit rooms_path
      # ルーム一覧ページにルームがあることを確認する
      expect(page).to have_content(@room.name)
      # 削除ボタンを押して、confirmダイアログでOKを選択して、topページに移動するとレコードの数が1減ることを確認する
      expect{
        page.accept_confirm do
          find_link('削除', href: room_path(@room)).click
        end
        expect(page).to have_content("こんにちは、#{@admin.name}さん")
      }.to change { Room.count }.by(-1)
      # ルーム一覧ページに遷移していることを確認する
      expect(current_path).to eq pages_top_path
      # ルーム一覧ページにルームが存在しないことを確認する
      expect(page).to have_no_content(@room.name)
    end
  end

  context 'ルーム削除ができないとき' do
    it 'ルームの作成者でなければ、ルームを削除できない' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # ルーム内に遷移しようとする
      visit room_messages_path(@room)
      # topページへ遷移することを確認する
      expect(current_path).to eq pages_top_path
    end

    it 'ログインしていなければ、ルームを削除する事ができない' do
      # indexページに遷移する
      visit root_path
      # ルーム内に遷移しようとする
      visit room_messages_path(@room)
      # ログイン画面に遷移した事を確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe "ルーム一覧", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @room = FactoryBot.create(:room)
    @room2 = FactoryBot.create(:room, name:"test2")
  end

  context 'ルーム一覧を見れるとき' do
    it 'ログインしたユーザーは、自身のルーム一覧を見る事ができる' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @room.user.email
      fill_in 'パスワード', with: @room.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # topページに2つのルームがあることを確認する
      expect(page).to have_content(@room.name)
      expect(page).to have_content(@room2.name)
      # ルーム一覧ページに遷移する
      visit room_path(@room.user)
      # ルーム一覧ページには自身の所属しているルームのみ表示されていることを確認する
      expect(page).to have_content(@room.name)
      expect(page).to have_no_content(@room2.name)
    end
  end

  context 'ルーム一覧を見れないとき' do
    it 'ログインしたユーザーは、自身以外のルーム一覧を見る事ができない' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # ルーム内に遷移しようとする
      visit room_path(@room.user)
      # topページへ遷移することを確認する
      expect(current_path).to eq pages_top_path
    end

    it 'ログインしていなければ、ルーム一覧ページを見る事ができない' do
      # indexページに遷移する
      visit root_path
      # ルーム内に遷移しようとする
      visit room_path(@room.user)
      # ログイン画面に遷移した事を確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe "ルーム管理ページ", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @admin = FactoryBot.create(:admin)
    @room = FactoryBot.create(:room)
    @room2 = FactoryBot.create(:room)
  end

  context 'ルーム管理ページを見れるとき' do
    it '管理者であれば、ルーム管理ページを見る事ができる' do
      # 管理者でログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @admin.email
      fill_in 'パスワード', with: @admin.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # topページに2つの投稿があることを確認する
      expect(page).to have_content(@room.name)
      expect(page).to have_content(@room2.name)
      # 投稿一覧ページに遷移する
      visit rooms_path
      # 投稿一覧ページにも2つの投稿があることを確認する
      expect(page).to have_content(@room.name)
      expect(page).to have_content(@room2.name)
    end
  end

  context 'ルーム管理ページを見れないとき' do
    it '管理者以外のユーザーはルーム一覧ページに遷移できない' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # 投稿一覧ページに遷移しようとする
      visit rooms_path
      # topページへ遷移することを確認する
      expect(current_path).to eq pages_top_path
    end

    it 'ログインしていないユーザーはルーム管理ページに遷移できない' do
      # indexページに遷移する
      visit root_path
      # 投稿一覧ページに遷移しようとする
      visit rooms_path
      # ログイン画面に遷移した事を確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end
