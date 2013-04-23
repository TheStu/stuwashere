class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :post_id
      t.integer :trip_id
      t.integer :gear_item_id
      t.string :flickr_url
      t.string :description
      t.string :print_url

      t.timestamps
    end
    add_index :pictures, :post_id
    add_index :pictures, :trip_id
    add_index :pictures, :gear_item_id
  end
end
