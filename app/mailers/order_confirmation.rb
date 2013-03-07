class OrderConfirmation < ActionMailer::Base
  default :from => DEFAULT_FROM #Sends multiple emails from DEFAULT_FORM which set in the config/mail_settings.rb
  def order_confirmation(order) #Function passes in order
    @order = order
    @url = "http://localhost:3000" #Url that links users to the correct address
    mail(:to => order.email, :subject => "Order Status Approved") #Subject of email

  end
end
