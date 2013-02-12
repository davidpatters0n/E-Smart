class AddImageProducts < ActiveRecord::Migration
  def up
    add_column :products, :image, :string
  end

  def down
  end
end
