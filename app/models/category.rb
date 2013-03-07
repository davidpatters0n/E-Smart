class Category < ActiveRecord::Base
  attr_accessible :name #Accessible attribute "name"

  #Association
  has_many :products #Categories have many products

  CATEGORIES = [ "Processor", "Graphics", "Networking", "Storage" ] #Pre-defined Categories.
end
