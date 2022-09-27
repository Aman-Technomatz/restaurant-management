class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :download]

  def index
    @orders = Order.all
  end

  def show
    @order_item = OrderItem.find_by(order_id: @order.id)
    @item = Item.find_by(id: @order_item.item_id)
    respond_to do |format|
      format.html
      format.pdf do
        # render pdf: 'test'
        # pdf = WickedPdf.new.pdf_from_string(render_to_string('orders/show'))
        # render pdf: pdf, template: 'orders/show', layout: 'pdf'
        # render pdf: 'Order id: #{@order.id}', template: 'orders/show.html.erb'
        render pdf: 'Order id: #{@order.id}', template: 'orders/show'
      end
    end
  end

  def new
    @order = Order.new
    @order.order_items.build
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to @order
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @order.order_items.build
  end

  def update

    if @order.update(order_params)
      redirect_to @order
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_url, status: :see_other
  end

  def download
    @order_item = OrderItem.find_by(order_id: @order.id)
    @item = Item.find_by(id: @order_item.item_id)
    pdf = Prawn::Document.new
    pdf.text "#{@item.name}
     #{@order_item.portion}
     #{@order_item.quantity}
     #{@order_item.total_price}"
    send_data(pdf.render,
        filename: "#{@order.id}",
        type: 'application/pdf')
  end

  def preview

  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(order_items_attributes: OrderItem.attribute_names.map(&:to_sym).push(:destroy))
    end

end
