class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def add_product(product_id)
    current_item = line_items.find_by_product_id(product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product_id)
      current_item.price = current_item.product.price
    end
    current_item
  end

=begin
The add product method takes in the product_id in the parenthesis
then takes in the line_items finds it by
product id. Performs an if statement to check if current_item
if it is the same item then increase the quantity. Else
add a new product to line of items.
=end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

=begin
 Method total price take line_items, .sum method
 calculates a sum from the item.
=end

end

