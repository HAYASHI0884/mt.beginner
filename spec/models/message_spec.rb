require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  describe 'メッセージ送信機能機能' do
    context 'メッセージが送信できる場合' do
      it 'text,imageがあれば送信できる' do
        expect(@message).to be_valid
      end

      it 'textがあれば送信できる' do
        @message.image = nil
        expect(@message).to be_valid
      end

      it 'imageがあれば送信できる' do
        @message.text = ""
        expect(@message).to be_valid
      end
    end

    context 'メッセージが送信できない場合' do
      it 'text,imageが空だと出品できない' do
        @message.text = ""
        @message.image = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Textを入力してください")
      end
    end
  end
end
