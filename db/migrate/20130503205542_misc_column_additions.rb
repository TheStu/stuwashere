class MiscColumnAdditions < ActiveRecord::Migration
  def change
    add_column :gear_items, :searchable, :boolean
    add_column :posts, :impression_count, :integer, default: 0
    add_column :avantlinks, :permanent, :boolean
  end
end
