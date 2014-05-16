module BlogHelper
	def base_part_of(file_name)
		File.basename(file_name).gsub(/[^\w._-]/,'')
	end

	def prev_picture(picture_id)
		pic = Picture.where("id < #{picture_id}").last
		if pic != nil
		   pic.id
		else
		   nil
		end
	end

	def next_picture(picture_id)
		pic = Picture.where("id > #{picture_id}").first
		if pic != nil
		   pic.id
		else
		   nil
		end
	end
end
