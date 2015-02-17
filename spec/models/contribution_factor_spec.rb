require 'rails_helper'

RSpec.describe ContributionFactor, :type => :model do

	it "should be only one per month" do
		ContributionFactor.new(factor: 1, initial_date: Date.new(2015, 2, 1)).save
		ContributionFactor.new(factor: 1, initial_date: Date.new(2015, 2, 12)).save

		expect(ContributionFactor.count).to eq(1)
	end

	it "biggest factor should be 100" do
		ContributionFactor.new(factor: 101, initial_date: Date.new(2015, 2, 1)).save

		expect(ContributionFactor.count).to eq(0)
	end

	it "shold be active until a new one is created" do
		ContributionFactor.new(factor: 1, initial_date: Date.new(2014, 1, 1)).save
		ContributionFactor.new(factor: 2, initial_date: Date.new(2015, 1, 1)).save

		contributionFactor = ContributionFactor.find_for_month(Date.new(2015,2,1))

		expect(contributionFactor.factor).to eq(2)
	end

end