class Maths
	def self.sum(entities, attribute)
		return entities.map(&attribute).inject(0, &:+) if entities
		0
	end
end