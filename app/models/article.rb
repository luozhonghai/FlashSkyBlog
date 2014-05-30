class Article < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
  has_many :tag_items, dependent: :destroy
  default_scope order: 'id desc'
  
	def add_comment(incomment)
		comments<<incomment
	end

  def tag_list
    self.tag_items.collect do|item| 
      item.tag.name
    end.join(",")
  end

  def tag_list=(tags)
    self.tag_items.clear
    tag_names = tags.split(",").collect{ |s| s.strip.downcase}.uniq
    tag_names.collect { |name| self.tag_items.build(tag: Tag.find_or_create_by(name: name))}
  end

end
