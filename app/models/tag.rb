class Tag < ActiveRecord::Base
  attr_accessible :name, :tag_count

  has_many :posts, through: :tagging
  has_many :taggings

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
