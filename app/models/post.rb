class Post < ActiveRecord::Base
  attr_accessible :content, :title, :trip_id, :tag_ids, :gear_item_id,
  :pictures_attributes, :impression_count

  has_many :tags, through: :taggings
  has_many :taggings
  has_many :pictures
  belongs_to :trip
  belongs_to :gear_item

  accepts_nested_attributes_for :pictures, :reject_if => lambda { |a| a[:flickr_url].blank? }, :allow_destroy => true

  include GetAvantlink
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
        tag.update_attributes(:tag_count => Tagging.where("tag_id = ?", tag.id).count)
      end
    end
  end

  def get_flickr
    self.pictures.each { |a| update_flickr_urls(a) unless a.flickr_small_url.present? }
  end

  def get_avantlinks
    if self.gear_item_id.present? && self.gear_item.searchable == true
      if self.gear_item.avantlinks.count == 0 || self.gear_item.avantlinks.first.created_at < Time.now - 1.week
        update_avantlink(self.gear_item)
      end
    end
  end

  def related
    self.find_by_tags do |posts|
      posts.sort_by do |p|
        matched_tags = p.tags.find_all {|t| self.tags.include?(t)}
        matched_tags.size
      end.reverse
    end
  end

  def find_by_tags
    tag_ids = self.tags.collect{|a| a.id}
    Post.includes(:taggings).where(["taggings.tag_id IN (?) AND taggings.post_id != ?", tags, self.id])
  end
end
