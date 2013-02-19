class AddCvvToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :cvv, :string
  end
end
