#Actionmailer method is SMTP form
ActionMailer::Base.delivery_method = :smtp
DEFAULT_FROM = "admin@e-smart.com"
=begin
When you recieve a email it wil have the above default address sender
=end
