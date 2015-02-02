require 'rails_helper'

RSpec.describe Contribution, :type => :model do
	before do
		Expense.delete_all
		Contribution.delete_all
		Contributor.delete_all
	end

	it "should exist only one in a month for same contributor" do
		contributor = CreateContributor()
		contributor.save
		budget_date = DateTime.new(2014,8,11)
		c = CreateContribution(budget_date, contributor)
		c.save
		
		budget_date = DateTime.new(2014,8,1)
		newC = CreateContribution(budget_date, contributor)
		newC.save

		expect(Contribution.count).to eq(1)
	end

	it "should always save contributions budget_date at midnight" do
		Contributor.new(firstName: 'any', lastName: 'any', email: 'any').save
		NewContribution(DateTime.new(2015,01,24,1,0,0), Contributor.find_by_email('any'), 1.0).save

		contrib = Contribution.first

		expect(contrib.budget_date).to eq(DateTime.new(2015,01,24,0,0,0))
	end

	def CreateContributor
		Contributor.new(firstName: 'any', lastName: 'any', email: 'any')
	end

	def CreateContribution(date, contributor)
		Contribution.new(:budget_date => date, :contributor => contributor, :amount => 0)
	end

	def NewContribution(date, contributor, amount)
		Contribution.new(:budget_date => date, :contributor => contributor, :amount => amount)
	end

	context "#get_contributions_for" do
		budget_date = DateTime.new(2014,01,01)
		
		it "should find contributions for a budget date" do
			contributor = Contributor.new(firstName: 'any', lastName: 'any', email: 'any')
			contributor.save
			Contribution.new(:budget_date => budget_date, :contributor => contributor, :amount => 1.0).save

			contributions_for_budget_month = Contribution.get_contributions_for_month(budget_date)

			expect(contributions_for_budget_month.size).to eq(1)
		end

		it "should find contributions from all contributors" do
			Contributor.new(firstName: 'first', lastName: 'any', email: 'any1').save
			Contributor.new(firstName: 'second', lastName: 'any', email: 'any2').save

			NewContribution(budget_date, Contributor.find_by_email('any1'), 1.0).save
			NewContribution(budget_date, Contributor.find_by_email('any2'), 1.0).save

			contributions_for_budget_month = Contribution.get_contributions_for_month(budget_date)

			expect(contributions_for_budget_month.size).to eq(2)
		end

		it "should find only the most recent contribution for a contributor" do
			Contributor.new(firstName: 'first', lastName: 'any', email: 'any1').save

			NewContribution(DateTime.new(2014,01,01), Contributor.find_by_email('any1'), 3.0).save
			NewContribution(DateTime.new(2013,12,01), Contributor.find_by_email('any1'), 2.0).save

			contributions_for_budget_month = Contribution.get_contributions_for_month(budget_date)

			expect(contributions_for_budget_month.size).to eq(1)
		end

		it "should transform datetime to utc before sending to database query" do
			midnight_first_feb_at_brasilia_summertime = DateTime.new(2014,02,01,0,0,0,'-2')
			midnight_first_jan_at_recife = DateTime.new(2014,01,01,0,0,0, '-3')
			Contributor.new(firstName: 'first', lastName: 'any', email: 'any1').save

			NewContribution(midnight_first_feb_at_brasilia_summertime, Contributor.find_by_email('any1'), 1.0).save

			contributions_for_budget_month = Contribution.get_contributions_for_month(midnight_first_jan_at_recife)

			expect(contributions_for_budget_month.size).to eq(0)
		end
	end
end
