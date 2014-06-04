class Picture < ActiveRecord::Base
  belongs_to :user
  has_many :pic_comments, dependent: :destroy

  def add_comment(incomment)
    pic_comments<<incomment
  end
end
