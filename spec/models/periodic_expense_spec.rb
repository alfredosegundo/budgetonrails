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

  context "#installment_cycles" do
    it 'should have a cycle length equals the amount of months of the installment' do
      expense = PeriodicExpense.new(start_date: DateTime.new(2014, 12, 1), end_date: DateTime.new(2015, 5, 30))

      expect(expense.installment_cycles).to eq 6
    end

    it 'should have a cycle length equals one when the installment starts and ends on the same month' do
      expense = PeriodicExpense.new(start_date: DateTime.new(2015, 5, 1), end_date: DateTime.new(2015, 5, 30))

      expect(expense.installment_cycles).to eq 1
    end

    it 'should have a cycle 0 when the installment starts after it ends' do
      expense = PeriodicExpense.new(start_date: DateTime.new(2016, 5, 1), end_date: DateTime.new(2015, 5, 30))

      expect(expense.installment_cycles).to eq 0
    end
  end

  context "#current_installment" do
    it 'should be one when budget_date is in the same month as start_date' do
      expense = PeriodicExpense.new(start_date: DateTime.new(2016, 5, 1), end_date: DateTime.new(2016, 10, 30))

      expect(expense.current_installment(DateTime.new(2016, 5, 10))).to eq 1
    end

    it 'should be the number of months passed since start_date' do
      expense = PeriodicExpense.new(start_date: DateTime.new(2016, 1, 1), end_date: DateTime.new(2016, 12, 31))

      expect(expense.current_installment(DateTime.new(2016, 4, 10))).to eq 4
    end

    it 'should be #installment_cycles when budget_date is after end_date' do
      expense = PeriodicExpense.new(start_date: DateTime.new(2014, 12, 1), end_date: DateTime.new(2015, 5, 31))

      expect(expense.current_installment(DateTime.new(2016, 11, 10))).to eq 6
    end

    it 'should be one when budget_date is in the same month as start_date' do
      expense = PeriodicExpense.new(start_date: DateTime.new(2016, 5, 1), end_date: DateTime.new(2016, 10, 31))

      expect(expense.current_installment(DateTime.new(2016, 5, 10))).to eq 1
    end
  end
end