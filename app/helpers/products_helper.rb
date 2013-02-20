module ProductsHelper
  def stock_left(product)
    product.stock - product.line_items.sum(:quantity)
  end
end
