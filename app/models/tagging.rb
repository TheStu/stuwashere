class Tagging < ActiveRecord::Base
  attr_accessible :post_id, :tag_id

  belongs_to :tag
  belongs_to :post
end
