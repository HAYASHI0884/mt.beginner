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
      fill_in '説明文(必須,140字以内)' , with: "introduction"
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

RSpec.describe '投稿編集', type: :system do
  before do
    @admin = FactoryBot.create(:admin)
    @tweet1 = FactoryBot.create(:tweet)
    @tweet2 = FactoryBot.create(:tweet)
  end
  context '投稿編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿した写真の編集ができる' do
      # 投稿1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @tweet1.user.email
      fill_in 'パスワード', with: @tweet1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # 投稿1の詳細ページへ遷移する
      visit tweet_path(@tweet1)
      # 投稿1の詳細ページに「編集」ボタンがあることを確認する
      expect(page).to have_content('編集')
      # 編集ページへ遷移する
      visit edit_tweet_path(@tweet1)
      # 投稿内容を編集する
      attach_file "tweet[image]", 'app/assets/images/test_image2.JPG'
      fill_in "タイトル(必須)", with: "#{@tweet1.title}+編集したテキスト"
      fill_in "説明文(必須,140字以内)", with: "#{@tweet1.introduction}+編集したテキスト"
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Tweet.count }.by(0)
      # 投稿1の詳細ページに遷移した事を確認する
      expect(current_path).to eq tweet_path(@tweet1)
      # 投稿1の詳細ページには先ほど変更した内容のツイートが存在することを確認する（画像）
      expect(page).to have_selector("img[src$='test_image2.JPG']")
      # 投稿1の詳細ページには先ほど変更した内容のツイートが存在することを確認する（タイトル）
      expect(page).to have_content("#{@tweet1.title}+編集したテキスト")
      # 投稿1の詳細ページには先ほど変更した内容のツイートが存在することを確認する（説明文）
      expect(page).to have_content("#{@tweet1.introduction}+編集したテキスト")
    end
    it '管理者であれば他者の投稿の編集を行う事ができる' do
      # 管理者でログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @admin.email
      fill_in 'パスワード', with: @admin.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # ヘッダーに「こんにちは、'adminの名前'さん」が表示されていることを確認する
      expect(page).to have_content("こんにちは、#{@admin.name}さん")
      # 投稿1の詳細ページへ遷移する
      visit tweet_path(@tweet1)
      # 投稿1の詳細ページに「編集」ボタンがあることを確認する
      expect(page).to have_content('編集')
      # 編集ページへ遷移する
      visit edit_tweet_path(@tweet1)
      # 投稿内容を編集する
      attach_file "tweet[image]", 'app/assets/images/test_image2.JPG'
      fill_in "タイトル(必須)", with: "#{@tweet1.title}+編集したテキスト"
      fill_in "説明文(必須,140字以内)", with: "#{@tweet1.introduction}+編集したテキスト"
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Tweet.count }.by(0)
      # 投稿1の詳細ページに遷移した事を確認する
      expect(current_path).to eq tweet_path(@tweet1)
      # 投稿1の詳細ページには先ほど変更した内容のツイートが存在することを確認する（画像）
      expect(page).to have_selector("img[src$='test_image2.JPG']")
      # 投稿1の詳細ページには先ほど変更した内容のツイートが存在することを確認する（タイトル）
      expect(page).to have_content("#{@tweet1.title}+編集したテキスト")
      # 投稿1の詳細ページには先ほど変更した内容のツイートが存在することを確認する（説明文）
      expect(page).to have_content("#{@tweet1.introduction}+編集したテキスト")
    end
  end

  context '投稿編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した写真の詳細画面では編集ボタンが表示されない' do
      # 投稿1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @tweet1.user.email
      fill_in 'パスワード', with: @tweet1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # 投稿2の詳細ページへ遷移する
      visit tweet_path(@tweet2)
      # 投稿2に「編集」ボタンがないことを確認する
      expect(page).to have_no_content('編集')
    end
    it 'ログインしたユーザーは自分以外が投稿した写真の編集画面には遷移できない' do
      # 投稿1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @tweet1.user.email
      fill_in 'パスワード', with: @tweet1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # 投稿2の編集ページに遷移しようとする
      visit edit_tweet_path(@tweet2)
      # topページへ遷移することを確認する
      expect(current_path).to eq pages_top_path
    end
    it 'ログインしていないと写真の編集画面には遷移できない' do
      # indexページに遷移する
      visit root_path
      # 投稿1の編集画面に遷移しようとする
      visit edit_tweet_path(@tweet1)
      # ログイン画面に遷移した事を確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe '投稿編集', type: :system do
  before do
    @admin = FactoryBot.create(:admin)
    @tweet1 = FactoryBot.create(:tweet)
  end
  context '投稿削除ができるとき' do
    it 'ログインしたユーザーは自分が投稿した写真の削除ができる' do
      # 投稿1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @tweet1.user.email
      fill_in 'パスワード', with: @tweet1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # 投稿1の詳細ページへ遷移する
      visit tweet_path(@tweet1)
      # 投稿1の詳細ページに「編集」ボタンがあることを確認する
      expect(page).to have_content('編集')
      # 編集ページへ遷移する
      visit edit_tweet_path(@tweet1)
      # 削除ボタンを押して、confirmダイアログでOKを選択するとレコードの数が1減ることを確認する
      expect{
        page.accept_confirm do
          find_link('削除', href: tweet_path(@tweet1)).click
        end
      }.to change{ Tweet.count }.by(0)
      # topページへ遷移することを確認する
      expect(current_path).to eq pages_top_path
      # topページには投稿1の内容が存在しないことを確認する（画像）
      expect(page).to have_no_selector("img[src$='test_image.png']")
      # topページには投稿1の内容が存在しないことを確認する（タイトル）
      expect(page).to have_no_content("#{@tweet1.title}")
    end
    it '管理者であれば他者の投稿の削除ができる' do
      # 管理者でログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @admin.email
      fill_in 'パスワード', with: @admin.password
      find('input[name="commit"]').click
      expect(current_path).to eq pages_top_path
      # ヘッダーに「こんにちは、'adminの名前'さん」が表示されていることを確認する
      expect(page).to have_content("こんにちは、#{@admin.name}さん")
      # 投稿1の詳細ページへ遷移する
      visit tweet_path(@tweet1)
      # 投稿1の詳細ページに「編集」ボタンがあることを確認する
      expect(page).to have_content('編集')
      # 編集ページへ遷移する
      visit edit_tweet_path(@tweet1)
      # 削除ボタンを押して、confirmダイアログでOKを選択するとレコードの数が1減ることを確認する
      expect{
        page.accept_confirm do
          find_link('削除', href: tweet_path(@tweet1)).click
        end
      }.to change{ Tweet.count }.by(0)
      # topページへ遷移することを確認する
      expect(current_path).to eq pages_top_path
      # topページには投稿1の内容が存在しないことを確認する（画像）
      expect(page).to have_no_selector("img[src$='test_image.png']")
      # topページには投稿1の内容が存在しないことを確認する（タイトル）
      expect(page).to have_no_content("#{@tweet1.title}")
    end
  end
end
