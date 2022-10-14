class OrderPdf < Prawn::Document
  def initialize(order, view, token)
    super(top_margin: 70)
    @order = order
    @view = view
    @token = token
    order_colour
    order_id
    total_price
  end

  def order_colour
    if @token.eql?('true')
      text "Token \##{TokenGenerator.call}", size: 30, style: :bold
    end
    text "Order Id \##{@order.id}", size: 30, style: :bold
  end

  def order_id
    table order_id_all do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true
    end
  end

  def order_id_all
      [['Item Name', 'Portion', 'Quantity', 'ItemPrice', 'Total Price']] +
      @order.order_items.map do  |order_detail|
        [order_detail.item.name, order_detail.portion, order_detail.quantity, price(order_detail.item.portions[order_detail.portion]) , price(order_detail.total_price)]
      end
  end

  def price(num)
    # @view.number_to_currency(num)
    "Rs. #{num}"
  end

  def total_price
    move_down 15
    text "Grand Total : #{price(@order.grand_total)}", size: 16, style: :bold

  end
end