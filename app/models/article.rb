class Article < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy

	def add_comment(incomment)
		comments<<incomment
	end
end
