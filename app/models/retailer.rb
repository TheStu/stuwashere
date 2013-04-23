class Retailer < ActiveRecord::Base
  attr_accessible :buy_url, :gear_item_id, :merchant_name

  belongs_to :gear_item
end
