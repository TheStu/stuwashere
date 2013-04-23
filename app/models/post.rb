class Post < ActiveRecord::Base
  attr_accessible :content, :title, :trip_id, :tag_ids, :gear_item_id,
  :pictures_attributes

  has_many :tags, through: :taggings
  has_many :taggings
  has_many :pictures
  belongs_to :trip
  belongs_to :gear_item

  accepts_nested_attributes_for :pictures, :reject_if => lambda { |a| a[:flickr_url].blank? }, :allow_destroy => true

  include GetFlickr
  include PgSearch
  multisearchable :against => [:content, :title]

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def add_pics_to_trip
    if self.pictures.present? && self.trip_id.present?
      self.pictures.each do |pic|
        pic.update_attributes(:trip_id => self.trip_id)
      end
    end
  end

  def tag_count_update
    if self.tags.present?
      self.tags.each do |tag|
        tag.update_attributes(:tag_count => Tag.where("name = ?", tag.name).count)
      end
    end
  end

  def get_flickr
    self.pictures.each { |a| update_flickr_urls(a) unless a.flickr_small_url.present? }
  end
end
