class GearItem < ActiveRecord::Base
  attr_accessible :name, :post_id, :weight, :intro, :front_picture_id

  has_many :retailers
  has_many :gear_listings
  has_many :gear_lists, through: :gear_listings
  has_many :pictures
  has_many :posts
  has_many :avantlinks

  include GetAvantlink
  include PgSearch
  multisearchable :against => [:name]

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def get_avantlinks
    if self.avantlinks.count == 0 || self.avantlinks.first.created_at < Time.now - 1.week
      update_avantlink(self)
    end
  end
end
