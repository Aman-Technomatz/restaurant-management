class OrderMailer < ApplicationMailer
  def send_order_mail(order, view_context)
    @order = order
    @view_context = view_context
    @token = false
    # attachments['receipt.pdf'] = File.read('app/pdfs/order_pdf.rb')

    invoice = OrderPdf.new(@order, @view_context, @token)
    attachments["invoice.pdf"] = { :mime_type => 'application/pdf', :content => invoice.render }
    # attachment :content_disposition => "attachment",
    # :body => OrderPdf.new(@order, view_context, params[:token]),
    # :content_type => "application/pdf",
    # :filename => 'invoice.pdf'

      mail(to: @order.customer.customer_email ,from:"atomar@technomatz.com",subject:"#{@order.customer.customer_name}",message:"")
  end
end
