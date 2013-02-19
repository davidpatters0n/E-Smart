class OrderMailerProcess < ActionMailer::Base
  default :from => DEFAULT_FROM
  def order_process(order)
    @order = order
    @url = "http://localhost:3000"
    mail(:to => order.email, :subject => "Order Status In Processing")

  end
end
