class CreateRetailers < ActiveRecord::Migration
  def change
    create_table :retailers do |t|
      t.integer :gear_item_id
      t.string :merchant_name
      t.string :buy_url

      t.timestamps
    end
    add_index :retailers, :gear_item_id
  end
end
