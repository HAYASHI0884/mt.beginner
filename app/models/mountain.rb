class Mountain < ApplicationRecord
  validates :name, presence: true

  belongs_to :area
  belongs_to :elevation
  belongs_to :climb_time
  has_one_attached :image
end
