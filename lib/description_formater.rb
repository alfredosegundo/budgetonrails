class DescriptionFormater
	def self.truncate(description)
		return "" if not description
    return description[0..19] + "..." if description.length > 20
    description[0..19]
	end
end