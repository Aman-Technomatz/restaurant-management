class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :download]

  def index
    @q = Order.ransack(params[:q])
    @orders = @q.result(distinct: true)
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        pdf = OrderPdf.new(@order, view_context, params[:token])
        send_data pdf.render,
                  filename: "#{@order.id}",
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end

  def new
    @customer = Customer.new
    @order = @customer.orders.new

    # @order = Order.new
    @order.order_items.build
  end

  def create
    @customer = Customer.find_or_create_by(order_params.slice(:customer_name, :customer_email))
    @order = @customer.orders.new(order_params)
    if @order.save
      # send email
      OrderMailer.send_order_mail(@order, view_context).deliver_now!
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

  def dashboard
    @daily_sale = Order.where(created_at: (Time.current.beginning_of_day..Time.current.end_of_day)).count
    @weekly_sale = Order.where(created_at: (Time.current.beginning_of_week..Time.current.end_of_week)).count
    @monthly_sale = Order.where(created_at: (Time.current.beginning_of_month..Time.current.end_of_month)).count
    @yearly_sale = Order.where(created_at: (Time.current.beginning_of_year..Time.current.end_of_year)).count
  end

  def send_mail
    OrderMailer.send_order_mail.delivery_now!
  end

   private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:customer_name, :customer_email, order_items_attributes: OrderItem.attribute_names.map(&:to_sym).push(:destroy))
    end

end
