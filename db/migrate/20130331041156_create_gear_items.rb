class CreateGearItems < ActiveRecord::Migration
  def change
    create_table :gear_items do |t|
      t.string :name
      t.integer :weight
      t.string :group_type
      t.integer :post_id

      t.timestamps
    end
  end
end
