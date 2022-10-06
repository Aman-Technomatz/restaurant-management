class Category < ApplicationRecord
  has_many :items, dependent: :destroy
  has_one_attached :image
  validates :name, presence: true
  # accepts_nested_attributes_for :items
end
