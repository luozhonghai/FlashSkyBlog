class PicComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :picture
  validates  :description, :presence => true
end
