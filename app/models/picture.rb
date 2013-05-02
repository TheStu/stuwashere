class Picture < ActiveRecord::Base
  attr_accessible :description, :flickr_url, :gear_item_id, :post_id, :print_url,
  :trip_id, :flickr_small_url, :flickr_medium_url, :flickr_large_url, :name

  belongs_to :post
  belongs_to :gear_item
  belongs_to :trip

  include GetFlickr

  scope :next, lambda {|id| where("id > ?",id).order("id ASC") } # this is the default ordering for AR
  scope :previous, lambda {|id| where("id < ?",id).order("id DESC") }

  def next
    Picture.next(self.id).first
  end

  def previous
    Picture.previous(self.id).first
  end

  def related
    before = Picture.where("id < ?", self.id).order('id DESC').first(4)
    after = Picture.where("id > ?", self.id).order('id ASC').first(4)
    final = (before.reverse << self) + after
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def get_flickr
    update_flickr_urls(self) unless flickr_small_url.present?
  end

  def update_flickr
    update_flickr_urls(self)
  end
end
