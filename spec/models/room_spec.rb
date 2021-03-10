require 'rails_helper'

RSpec.describe Room, type: :model do
  before do
    @room = FactoryBot.build(:room)
  end

  describe 'チャットルーム作成機能' do
    context 'チャットルームを作成できる場合' do
      it 'nameがあれば出品できる' do
        expect(@room).to be_valid
      end
    end

    context 'チャットルームを作成できない場合' do
      it 'nameが空だと出品できない' do
        @room.name = ''
        @room.valid?
        expect(@room.errors.full_messages).to include('ルーム名を入力してください')
      end
    end
  end
end
