class User < ActiveRecord::Base
  has_many  :articles, dependent: :destroy
  has_many  :pictures, dependent: :destroy
  has_many  :messages, dependent: :destroy
  validates :name, :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 6} , if: :not_reset_pw
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
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

  def not_reset_pw
    return self.verify_key == nil
  end
end
