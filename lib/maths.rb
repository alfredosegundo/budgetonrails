class Maths
	def self.sum(entities, attribute)
		return entities.map(&attribute).inject(0, &:+) if entities
		0
	end

  def self.sum_multiplied_by(entities, attribute, multiplier)
    return self.sum(entities, attribute) * multiplier
  end
end