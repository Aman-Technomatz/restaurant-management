class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order
  before_save :update_total_price

  # calculate total_price
  def update_total_price
    self.total_price = item.portions[portion].to_i * quantity
  end

  # attr_accessor :customer_name, :customer_email
  # def test
  # end
end
