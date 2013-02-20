class ChangeStockTypeInMyOrderTable < ActiveRecord::Migration
  def up
    change_column :products, :stock, :integer
  end

  def self.down
    change_column :products, :stock, :string
  end
end
