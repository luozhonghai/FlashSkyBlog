class Article < ActiveRecord::Base
	has_many :comments, dependent: :destroy

	def add_comment(incomment)
		comments<<incomment
	end
end
