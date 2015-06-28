require 'rails_helper'

RSpec.describe ExpectedExpense, :type => :model do
  some_date = Date.new(2015,06,28)
  context "entity validation" do
    it "should not save wihtout description" do
      ExpectedExpense.new(value: "value", initial_date: some_date, final_date: some_date).save

      result = ExpectedExpense.all.size

      expect(result).to eq 0
    end

    it "should not save without a value" do
      ExpectedExpense.new(description: "some", initial_date: some_date, final_date: some_date).save

      result = ExpectedExpense.all.size

      expect(result).to eq 0
    end

    it "should not save without an initial_date" do
      ExpectedExpense.new(value: "value", description: "some", final_date: some_date).save

      result = ExpectedExpense.all.size

      expect(result).to eq 0
    end

    it "should move initial date to the beggining of the month" do
      ExpectedExpense.new(description: "some", value: "value", 
        initial_date: Date.new(2015,06,30), final_date: some_date).save

      expense = ExpectedExpense.all.first

      expect(expense.initial_date).to eq(Date.new(2015,06,01))
    end
    it "should move final date to the end of the month" do
      ExpectedExpense.new(description: "some", value: "value", 
        initial_date: some_date, final_date: Date.new(2015,06,3)).save

      expense = ExpectedExpense.all.first

      expect(expense.final_date).to eq(Date.new(2015,06,30))
    end
  end

  context "#not_realized_on" do
    budget_date = DateTime.new(2014,9,1)

    it "should return an empty array if there is no expected_expenses" do
      result = ExpectedExpense.not_realized_on budget_date

      expect(result.size).to eq 0
    end

    it "should return expected_expenses if there is a not realized one" do
      ExpectedExpense.new(description: "some", value: 10, initial_date: budget_date, final_date: budget_date).save

      result = ExpectedExpense.not_realized_on budget_date

      expect(result.size).to eq 1
    end

    it "should return only not realized expenses" do
      ee = ExpectedExpense.new(description: "some", value: 10, initial_date: budget_date, final_date: budget_date)
      ee.save
      ee.expenses << Expense.new(value: 10, description: "some", budget_date: budget_date)

      result = ExpectedExpense.not_realized_on budget_date

      expect(result.size).to eq 0
    end

    it "should avoid duplications" do
      ExpectedExpense.new(description: "some", value: 20, initial_date: budget_date, final_date: budget_date).save

      ee = ExpectedExpense.new(description: "some", value: 10, initial_date: budget_date, final_date: budget_date)
      ee.save
      ee.expenses << Expense.new(value: 10, description: "some", budget_date: budget_date)
      ee.expenses << Expense.new(value: 10, description: "some", budget_date: 2.months.ago)

      result = ExpectedExpense.not_realized_on budget_date

      expect(result.size).to eq 1
    end

    it "should show for a not realized month" do
      ee = ExpectedExpense.new(description: "some", value: 10, 
                               initial_date: Date.new(2014,1,1), final_date: Date.new(2014,12,31))
      ee.save
      ee.expenses << Expense.new(value: 10, description: "some", budget_date: DateTime.new(2014,2,1))

      result = ExpectedExpense.not_realized_on DateTime.new(2014,3,1)

      expect(result.size).to eq 1
    end
  end


end
