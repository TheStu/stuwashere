class GearList < ActiveRecord::Base
  attr_accessible :intro, :trip_id, :gear_item_ids, :gear_listing,
  :gear_listings_attributes

  belongs_to :trip
  has_many :gear_listings
  has_many :gear_items, through: :gear_listings

  accepts_nested_attributes_for :gear_listings, :reject_if => lambda { |a| a[:quantity].blank? || a[:quantity] == 0 }, :allow_destroy => true

  include PgSearch
  multisearchable :against => [:intro]

  def to_param
    "#{id}-#{trip.name.parameterize}-gear-list"
  end
end
