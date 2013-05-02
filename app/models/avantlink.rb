class Avantlink < ActiveRecord::Base
  attr_accessible :brand_name, :buy_url, :gear_item_id, :merchant_name, :product_name, :sale_price

  belongs_to :gear_item
end
