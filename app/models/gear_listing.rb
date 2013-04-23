class GearListing < ActiveRecord::Base
  attr_accessible :gear_item_id, :gear_list_id, :quantity, :group_type

  belongs_to :gear_list
  belongs_to :gear_item
end
