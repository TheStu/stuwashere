class CreateAvantlinks < ActiveRecord::Migration
  def change
    create_table :avantlinks do |t|
      t.integer :gear_item_id
      t.string :merchant_name
      t.string :product_name
      t.string :brand_name
      t.string :sale_price
      t.string :buy_url

      t.timestamps
    end
    add_index :avantlinks, :gear_item_id
  end
end
