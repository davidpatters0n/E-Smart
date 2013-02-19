class OrderConfirmation < ActionMailer::Base
  default :from => DEFAULT_FROM
  def order_confirmation(order)
    @order = order
    @url = "http://localhost:3000"
    mail(:to => order.email, :subject => "Order Status Approved")

  end
end
