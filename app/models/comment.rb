class Comment < ActiveRecord::Base
	belongs_to :article
	validates :description, :user, :mail, :presence => true
end
