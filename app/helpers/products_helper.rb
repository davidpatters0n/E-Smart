module ProductsHelper

  def stock_left(product)
    product.stock - product.line_items.sum(:quantity)
  end

=begin
  Helper method is called in the "Product/index.html.erb"
  The stock_left method passes in the product and then
  sums the "stock_left" by doing stock - line_item = Quantity.
=end
end
