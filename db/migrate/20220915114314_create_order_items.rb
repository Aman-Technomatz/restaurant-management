class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.string :portion
      t.integer :quantity
      t.integer :total_price
      t.timestamps
    end
  end
end
