class User < ActiveRecord::Base
  has_many  :articles, dependent: :destroy
  has_many  :pictures, dependent: :destroy
  has_many  :messages, dependent: :destroy
  validates :name, :email, presence: true, uniqueness: true
  has_secure_password

  def add_article(inarticle)
    articles<<inarticle
  end

  def add_picture(inpicture)
    pictures<<inpicture
  end

  def add_message(inmessage)
    messages<<inmessage
  end
end
