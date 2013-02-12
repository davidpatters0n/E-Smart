class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :address
      t.string :card_type
      t.date :card_expires_on
      t.string :ip_address

      t.timestamps
    end
  end
end
