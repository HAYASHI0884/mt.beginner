require 'rails_helper'

RSpec.describe Mountain, type: :model do
  before do
    @mountain = FactoryBot.build(:mountain)
  end

  describe '山登録機能' do
    context '山を登録できる場合' do
      it 'name,area_id,elevation_id,climb_time_idがあれば出品できる' do
        expect(@mountain).to be_valid
      end
    end

    context '山が登録できない場合' do
      it 'nameが空だと登録できない' do
        @mountain.name = ''
        @mountain.valid?
        expect(@mountain.errors.full_messages).to include("Nameを入力してください")
      end

      it 'area_idが空だと登録できない' do
        @mountain.area = nil
        @mountain.valid?
        expect(@mountain.errors.full_messages).to include("Areaを入力してください")
      end

      it 'elevation_idが空だと登録できない' do
        @mountain.elevation = nil
        @mountain.valid?
        expect(@mountain.errors.full_messages).to include("Elevationを入力してください")
      end

      it 'climb_time_idが空だと登録できない' do
        @mountain.climb_time = nil
        @mountain.valid?
        expect(@mountain.errors.full_messages).to include("Climb timeを入力してください")
      end
    end
  end
end
