class AddVariousColumns < ActiveRecord::Migration
  def change
    add_column :trips, :start_date, :datetime
    add_column :trips, :end_date, :datetime
    add_column :trips, :front_picture_id, :integer
    add_column :gear_listings, :quantity, :integer
    add_column :gear_items, :intro, :text
    add_column :posts, :gear_item_id, :integer
    add_column :pictures, :flickr_small_url, :string
    add_column :pictures, :flickr_medium_url, :string
    add_column :pictures, :flickr_large_url, :string
    remove_column :gear_lists, :name
  end
end
