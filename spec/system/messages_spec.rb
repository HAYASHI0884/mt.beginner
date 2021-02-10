require 'rails_helper'

RSpec.describe "メッセージ送信", type: :system do
  before do
    @room = FactoryBot.create(:room)
    @message = FactoryBot.build(:message)
  end

  context 'メッセージ送信ができるとき'do
    it 'ルームの参加者ユーザーはメッセージ送信ができる' do
      # ルームの参加者でログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @room.user.email
      fill_in 'パスワード', with: @room.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # topページにルームが存在することを確認する
      expect(page).to have_content(@room.name)
      # チャットルームに遷移する
      visit room_messages_path(@room)
      # フォームに情報を入力する
      attach_file "画像", 'app/assets/images/test_image.png', make_visible: true
      fill_in 'message[text]', with: @message.text
      # 送信するとMessageモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)
      # ルーム内には先ほど送信した内容が存在することを確認する
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@message.text)
    end
  end

  context 'メッセージ送信ができないとき' do
    it 'フォームに何も入れないときはメッセージ送信ができない' do
      # ルームの参加者でログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @room.user.email
      fill_in 'パスワード', with: @room.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # topページにルームが存在することを確認する
      expect(page).to have_content(@room.name)
      # チャットルームに遷移する
      visit room_messages_path(@room)
      # そのまま送信してもMessageモデルのカウントは変化しないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Message.count }.by(0)
    end
  end
end
