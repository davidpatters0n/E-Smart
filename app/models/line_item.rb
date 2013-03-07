  class LineItem < ActiveRecord::Base
 #  #Accessible attributes that uses mass-assignemnt so that attributes can be accessed from other models.
  attr_accessible :cart_id, :product_id, :quantity

  ###############
  # Associations#
  ###############
  belongs_to :product
  belongs_to :cart
  belongs_to :order


  ###############
  # Hook Methods#
  ###############
  def total_price
    product.price * quantity
  end
    #Simple product price * quantity.
end
