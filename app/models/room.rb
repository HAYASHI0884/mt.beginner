class Room < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :users, through: :entries
end
