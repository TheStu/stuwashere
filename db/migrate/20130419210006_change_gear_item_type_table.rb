class ChangeGearItemTypeTable < ActiveRecord::Migration
  def change
    remove_column :gear_items, :group_type
    add_column :gear_listings, :group_type, :string
    add_index :gear_listings, :group_type
  end
end
