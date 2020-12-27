require 'rails_helper'

RSpec.describe Tweet, type: :model do
  before do
    @tweet = FactoryBot.build(:tweet)
  end

  describe '写真投稿機能' do
    context '写真を投稿できる場合' do
      it 'title,introduction,imageがあれば出品できる' do
        expect(@tweet).to be_valid
      end
    end

    context '写真が投稿できない場合' do
      it 'titleが空だと出品できない' do
        @tweet.title = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("タイトルを入力してください")
      end

      it 'introductionが空だと出品できない' do
        @tweet.introduction = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("説明文を入力してください")
      end

      it 'imageが空だと出品できない' do
        @tweet.image = nil
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("画像ファイルを添付してください")
      end
    end
  end
end
