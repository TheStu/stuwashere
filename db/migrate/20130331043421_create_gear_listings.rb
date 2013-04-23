class CreateGearListings < ActiveRecord::Migration
  def change
    create_table :gear_listings do |t|
      t.integer :gear_item_id
      t.integer :gear_list_id

      t.timestamps
    end
  end
end
