class CreateGearLists < ActiveRecord::Migration
  def change
    create_table :gear_lists do |t|
      t.integer :trip_id
      t.string :name
      t.text :intro

      t.timestamps
    end
  end
end
