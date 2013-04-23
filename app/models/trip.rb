class Trip < ActiveRecord::Base
  attr_accessible :completed, :intro, :name, :start_date, :end_date,
  :front_picture_id

  has_one :gear_list
  has_many :posts
  has_many :pictures

  include PgSearch
  multisearchable :against => [:intro, :name]

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
