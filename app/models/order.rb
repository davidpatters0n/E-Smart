class Order < ActiveRecord::Base
  attr_accessible :address, :card_expires_on, :card_type, :ip_address
  belongs_to :cart
  has_many :line_items, :dependent => :destroy

  CARD_TYPES = ["Visa", "visa", "MasterCard", "master", "Discover", "discover", "American Express", "american_express"]

  validates_presence_of :card_expires_on, :card_type, :address
  validates :card_type, :inclusion => CARD_TYPES

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

=begin
  class Order
    self.per_page = 10
  end
=end

end
