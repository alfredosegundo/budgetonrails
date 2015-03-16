require "Maths"

RSpec.describe Maths do
	context "sum" do
		Entity = Class.new do
			def initialize(value)
				@value = value
			end
			attr_reader :value
		end

		it "should return zero for empty entities" do
			sum = Maths.sum([], :attr)

			expect(sum).to eq(0)
		end

		it "should sum given attribute" do
			entities = [Entity.new(1),Entity.new(1)]
			
			sum = Maths.sum(entities, :value)

			expect(sum).to eq(2)
		end

	end
end