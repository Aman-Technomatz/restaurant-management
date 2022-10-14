class OrderMailer < ApplicationMailer
  def send_order_mail
      mail(to:"atomar@technomatz.com",from:"atomar@technomatz.com",subject:"Testing mail",message:"hi!!")
  end
end
