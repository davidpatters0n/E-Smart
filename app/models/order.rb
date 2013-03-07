class Order < ActiveRecord::Base
  #Accessible attributes that uses mass-assignemnt so that attributes can be accessed from other models.
  attr_accessible :address, :card_expires_on, :card_type, :ip_address, :card_number, :email, :quantity,
                  :user_id, :status, :first_name, :last_name, :email, :cvv, :title
  #Purpose of attr_accessible is to for mass assignment. This is used when a model wants to access attributes outside it

  ###############
  # Associations#
  ###############

  belongs_to :cart #An order belongs to a cart.
  has_many :line_items, :dependent => :destroy   #If an oder is deleted so must the line items
  belongs_to :user  #One order belongs to a user


  #################################
  #Active Record Nested Attributes#
  #################################
  accepts_nested_attributes_for :user # accepts_nested_attributes allows me to save records via the Activerecord association
  accepts_nested_attributes_for :line_items

  #List of card typed that will be used in drop down.
  CARD_TYPES = ["Visa", "visa", "Visa Electron", "visa_electron" "MasterCard", "master", "American Express", "american_express", "Solo", "solo", "Maestro", "maestro"]
  STATUS = [ "Processing", "Approved", "Rejected" ]

  #############
  # Validation#
  #############

  validates_presence_of :card_expires_on, :card_type, :address #Ensures that these attributes are not left blank.
  validates :card_type, :inclusion => CARD_TYPES

  ###############
  # Hook Methods#
  ###############

  def add_line_items_from_cart(cart)
    #for each linetime added to the cart remove thh cart id and add to order
  cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def quantity
    line_items.to_a.sum { |quant| quant.quantity }
  end
  #Above quantity method performs a lambda that sums the line_items by passing in the quantity method

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
  #Above total_price method performs a lambda that sums the line_items by passing in the total_price method

end
