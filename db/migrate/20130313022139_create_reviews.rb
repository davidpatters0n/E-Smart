class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :author
      t.text :content
      t.integer :rating
      t.references :product

      t.timestamps
    end
    add_index :reviews, :product_id
  end
end
