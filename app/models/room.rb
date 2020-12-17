class Room < ApplicationRecord
  validates :name,     presence: true
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_one_attached :image
end
