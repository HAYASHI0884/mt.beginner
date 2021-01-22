class Tweet < ApplicationRecord
  belongs_to :user
  has_one_attached :image, dependent: :destroy

  validates :title, presence: true
  validates :introduction, presence: true, length:{maximum:140}
  validate :image_presence

  def image_presence
    if image.attached?
      errors.add(:image, 'にはjpegまたはpngファイルを添付してください') unless image.content_type.in?(%('image/jpeg image/png'))
    else
      errors.add(:image, 'ファイルを添付してください')
    end
  end
end
