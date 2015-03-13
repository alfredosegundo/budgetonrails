require 'rails_helper'

RSpec.describe Expense, :type => :model do
	context "#get_expenses_sum_for" do
		budget_date = DateTime.new(2014,9,1)
		it "should return expenses in budget month" do
			expense_inside_budget_date = Expense.new(description: "any", value: 1.0, budget_date: budget_date)
			expense_outside_budget_date = Expense.new(description: "any", value: 1.0, budget_date: DateTime.new(2014,1,1))
			expense_inside_budget_date.save
			expense_outside_budget_date.save

			expense_for_budget_month = Expense.get_expenses_sum_for(budget_date)

			expect(expense_for_budget_month).to eq(1.0)
		end

		it "should sum all expenses in the same month" do
			Expense.new(description: "any", value: 1.0, budget_date: DateTime.new(2014,9,2)).save
			Expense.new(description: "any", value: 1.0, budget_date: DateTime.new(2014,9,3)).save

			expense_for_budget_month = Expense.get_expenses_sum_for(budget_date)

			expect(expense_for_budget_month).to eq(2.0)
		end
	end
end