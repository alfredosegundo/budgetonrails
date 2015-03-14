require 'rails_helper'

RSpec.describe PeriodicExpense, :type => :model do
	any_date = DateTime.new 2015, 3, 12
	context "entity validation" do
		it "should not save when description is empty" do
			saved = PeriodicExpense.new(description: "", value: 1.0, start_date: any_date, end_date: any_date).save
			
			expect(saved).to eq(false)
		end

		it "should not save when value is less or equal to zero" do
			saved = PeriodicExpense.new(description: "any", value: 0.0, start_date: any_date, end_date: any_date).save
			
			expect(saved).to eq(false)
		end
	end

	context "#get_expenses_for_month" do
		it "should return all expenses in a given month" do
			PeriodicExpense.new(description: "any", value: 1.0, 
				start_date: DateTime.new(2015, 1, 1), end_date: DateTime.new(2015, 2, 1)).save

			expenses = PeriodicExpense.get_expenses_for_month(DateTime.new(2015, 1, 2))

			expect(expenses.size).to eq 1
		end

		it "should return all expenses in a given month even for instant periodic expenses" do
			PeriodicExpense.new(description: "any", value: 1.0,
				start_date: DateTime.new(2015, 3, 1), end_date: DateTime.new(2015, 3, 1)).save

			expenses = PeriodicExpense.get_expenses_for_month(DateTime.new(2015, 3, 1))

			expect(expenses.size).to eq 1
		end

		it "should return all expenses in a given month even for expenses inside month" do
			PeriodicExpense.new(description: "any", value: 1.0,
				start_date: DateTime.new(2015, 2, 1), end_date: DateTime.new(2015, 3, 1)).save

			expenses = PeriodicExpense.get_expenses_for_month(DateTime.new(2015, 3, 14))

			expect(expenses.size).to eq 1
		end
	end
end