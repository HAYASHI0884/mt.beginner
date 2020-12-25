class Message < ApplicationRecord
  validates :text, presence: true, unless: :was_attached?

  belongs_to :user
  belongs_to :room
  has_one_attached :image, dependent: :destroy

  def was_attached?
    image.attached?
  end
end
