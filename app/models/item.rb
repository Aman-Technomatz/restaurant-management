class Item < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  has_many :order_items, dependent: :destroy
  # PORTION_NAMES = %w[single double triple]
  validates :name, presence: true
  validates :portions, presence: true
end
