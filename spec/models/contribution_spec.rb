require 'rails_helper'

RSpec.describe Contribution, :type => :model do
	it "should reject two contributions in the same month for same contributor" do
		contributor = CreateContributor()
		contributor.save
		creation_date = Date.new(2014,8,11)
		c = FakeContribution(creation_date, contributor)
		c.save
		
		creation_date = Date.new(2014,8,1)
		newC = FakeContribution(creation_date, contributor)
		newC.save

		expect(Contribution.count).to eq(1)
	end

	def CreateContributor
		Contributor.new(:firstName => 'any', :lastName => 'any', :email => 'any')
	end

	def FakeContribution(creation_date, contributor)
		Contribution.new(:created_at => creation_date, :contributor => contributor, :amount => 0)
	end
end
