class GearItem < ActiveRecord::Base
  attr_accessible :name, :post_id, :weight, :intro, :front_picture_id

  has_many :retailers
  has_many :gear_listings
  has_many :pictures
  has_many :posts

  include PgSearch
  multisearchable :against => [:name]

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
