class AddFrontPictureIdToGearItems < ActiveRecord::Migration
  def change
    add_column :pictures, :name, :string
    add_column :gear_items, :front_picture_id, :integer
  end
end
