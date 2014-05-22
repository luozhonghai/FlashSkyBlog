class User < ActiveRecord::Base
  has_many  :articles, dependent: :destroy
  has_many  :pictures, dependent: :destroy
  validates :name, :email, presence: true, uniqueness: true
  has_secure_password

  def add_article(inarticle)
    articles<<inarticle
  end

  def add_picture(inpicture)
    pictures<<inpicture
  end
end
