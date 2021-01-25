require 'rails_helper'

RSpec.describe "写真投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context '写真投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # 新規投稿画面へのリンクがあることを確認する
      expect(page).to have_content('新規投稿はこちら')
      # 新規投稿画面に移動する
      visit new_tweet_path
      # フォームに情報を入力する
      attach_file "tweet[image]", 'app/assets/images/test_image.png'
      fill_in 'タイトル(必須)', with: "title"
      fill_in '説明文' , with: "introduction"
      # 送信するとTweetモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Tweet.count }.by(1)
      # トップページに遷移する事を確認する
      expect(current_path).to eq pages_top_path
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（画像）
      expect(page).to have_selector("img[src$='test_image.png']")
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（タイトル）
      expect(page).to have_content("title")
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（ユーザーネーム）
      expect(page).to have_content("#{@user.name}")
    end
  end
  context '写真投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # indexページに遷移する
      visit root_path
      # 新規投稿画面に遷移しようとする
      visit new_tweet_path
      # ログイン画面に遷移した事を確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end
