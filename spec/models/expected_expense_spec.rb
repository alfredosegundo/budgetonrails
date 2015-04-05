require 'rails_helper'

RSpec.describe ExpectedExpense, :type => :model do
  context "entity validation" do
    it "should not save wihtout description" do
      ExpectedExpense.new.save

      result = ExpectedExpense.all

      expect(result.size).to eq 0
    end

    it "should not save without a value" do
      ExpectedExpense.new(description: "some").save

      result = ExpectedExpense.all

      expect(result.size).to eq 0
    end
  end

  context "#not_realized_on" do
    budget_date = DateTime.new(2014,9,1)

    it "should return an empty array if there is no expected_expenses" do
      result = ExpectedExpense.not_realized_on budget_date

      expect(result.size).to eq 0
    end

    it "should return expected_expenses if there is a not realized one" do
      ExpectedExpense.new(description: "some", value: 10).save

      result = ExpectedExpense.not_realized_on budget_date

      expect(result.to_a.size).to eq 1
    end

    it "should return only not realized expenses" do
      ee = ExpectedExpense.new(description: "some", value: 10)
      ee.save
      ee.expenses << Expense.new(value: 10, description: "some", budget_date: budget_date)

      result = ExpectedExpense.not_realized_on budget_date

      expect(result.size).to eq 0
    end
  end

  
end