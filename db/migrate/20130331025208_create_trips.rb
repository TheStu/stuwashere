class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :name
      t.boolean :completed
      t.text :intro

      t.timestamps
    end
  end
end
