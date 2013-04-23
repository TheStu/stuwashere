class Picture < ActiveRecord::Base
  attr_accessible :description, :flickr_url, :gear_item_id, :post_id, :print_url,
  :trip_id, :flickr_small_url, :flickr_medium_url, :flickr_large_url, :name

  belongs_to :post
  belongs_to :gear_item
  belongs_to :trip

  include GetFlickr

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def get_flickr
    update_flickr_urls(self) unless flickr_small_url.present?
  end
end
