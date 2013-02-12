class Product < ActiveRecord::Base
  include FilterScope
  default_scope :order => 'title'

  attr_accessible :name, :description, :image_url, :price, :title, :image, :image_cache, :category_id
  mount_uploader :image, ImageUploader  #mounts the uploader to the given column in this case which it is :image
  belongs_to :category
  has_many :line_items


  before_destroy :ensure_not_referenced_by_any_line_item  #Hook method that is called before destroying product

  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?    #if line_items is zero return true delete it.
      return true
    else
      errors.add(:base, 'Line Items present')   #Else do not destroy line_item.
      return false
    end
  end

  def total_price
    product.price * quantity
  end
  #Simple product price * quantity.
end
