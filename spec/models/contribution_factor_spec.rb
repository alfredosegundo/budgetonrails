require 'rails_helper'

RSpec.describe ContributionFactor, :type => :model do

	it "should have only one in a month" do
		ContributionFactor.new(factor: 85.2, initial_date: Date.new(2015, 2, 1)).save
		ContributionFactor.new(factor: 85.2, initial_date: Date.new(2015, 2, 12)).save

		expect(ContributionFactor.count).to eq(1)
	end

end