class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order
  before_save :update_total_price
  validates :quantity, presence: true, length: { minimum: 1 }

  # calculate total_price
  def update_total_price
    self.total_price = item.portions[portion].to_i * quantity
  end

end
