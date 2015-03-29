require 'rails_helper.rb'
require 'maths.rb'

RSpec.describe Maths do
  Entity = Class.new do
    def initialize(value)
      @value = value
    end
    attr_reader :value
  end

  context "#sum_multiplied_by" do
    it "should be zero for empty entities" do
      sum = Maths.sum_multiplied_by([], :attr, 1)

      expect(sum).to eq(0)
    end

    it "should sum entities values appling a multiplier" do
      sum = Maths.sum_multiplied_by([Entity.new(10)], :value, 0.5)

      expect(sum).to eq(5)
    end

    it "should sum each entities values appling a multiplier" do
      sum = Maths.sum_multiplied_by([Entity.new(10), Entity.new(5)], :value, 0.5)

      expect(sum).to eq(7.5)
    end
  end

  context "sum" do

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