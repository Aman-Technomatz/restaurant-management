class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :download]

  def index
    @orders = Order.all
    @monthly_sale = Order.where(created_at: (Time.current.beginning_of_month..Time.now.end_of_month)).count
    @yearly_sale = Order.where(created_at: (Time.current.beginning_of_year..Time.now.end_of_month)).count
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        pdf = OrderPdf.new(@order, view_context)
        send_data pdf.render,
                  filename: "#{@order.id}",
                  type: 'application/pdf',
                  disposition: 'inline'
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

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(order_items_attributes: OrderItem.attribute_names.map(&:to_sym).push(:destroy))
    end

end
