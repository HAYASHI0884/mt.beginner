class Room < ApplicationRecord
  validates :name,     presence: true
  validates :password, presence: true
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
end
