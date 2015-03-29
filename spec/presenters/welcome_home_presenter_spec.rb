require 'rails_helper.rb'

RSpec.describe WelcomeHomePresenter do
  describe "#budget_date" do
    it "should return empty string for invalid date" do
      presenter = WelcomeHomePresenter.new(budget_date: nil)

      budget_date = presenter.budget_date

      expect(budget_date).to eq("")
    end

    it "should return month and year for a date" do
      presenter = WelcomeHomePresenter.new(budget_date: DateTime.new(2015,1,1))

      budget_date = presenter.budget_date

      expect(budget_date).to eq("January 2015")
    end
  end

  describe "#expenses" do
    it "should return an array with EmptyExpense if no expenses provided" do
      presenter = WelcomeHomePresenter.new(expenses: [])

      expenses = presenter.expenses

      expect(expenses.size).to eq(0)
    end

    it "should return a expense if provided" do
      presenter = WelcomeHomePresenter.new(expenses: [Expense.new])

      expenses = presenter.expenses

      expect(expenses.size).to eq(1)
    end

    it "should return expenses and periodic_expenses" do
      presenter = WelcomeHomePresenter.new(expenses: [Expense.new], periodic_expenses: [PeriodicExpense.new])

      expenses = presenter.expenses

      expect(expenses.size).to eq(2)
    end

    it "should return expenses if periodic_expenses are nil" do
      presenter = WelcomeHomePresenter.new(expenses: [Expense.new])

      expenses = presenter.expenses

      expect(expenses.size).to eq(1)
    end

    it "should return periodic_expenses if expenses are nil" do
      presenter = WelcomeHomePresenter.new(periodic_expenses: [PeriodicExpense.new])

      expenses = presenter.expenses

      expect(expenses.size).to eq(1)
    end

    it "should return an array with EmptyExpense if both periodic_expenses and expenses are nil" do
      presenter = WelcomeHomePresenter.new(expenses: nil, periodic_expenses: nil)

      expenses = presenter.expenses

      expect(expenses.size).to eq(0)
    end

    it "should return an array with EmptyExpense if both periodic_expenses and expenses are empty" do
      presenter = WelcomeHomePresenter.new(expenses: [], periodic_expenses: [])

      expenses = presenter.expenses

      expect(expenses.size).to eq(0)
    end
  end

  describe "#total_expenses" do
    it "should return 0 when expenses are empty" do
      presenter = WelcomeHomePresenter.new(expenses: [], periodic_expenses: [])

      result = presenter.total_expenses

      expect(result).to eq(0)
    end

    it "should return sum of all expenses provided" do
      presenter = WelcomeHomePresenter.new(expenses: [Expense.new(value: 1)])

      result = presenter.total_expenses

      expect(result).to eq(1)
    end

    it "should return sum of all periodic_expenses provided" do
      presenter = WelcomeHomePresenter.new(periodic_expenses: [PeriodicExpense.new(value: 1)])

      result = presenter.total_expenses

      expect(result).to eq(1)
    end

    it "should return sum of all periodic_expenses and expenses provided" do
      presenter = WelcomeHomePresenter.new(expenses: [Expense.new(value: 1)], periodic_expenses: [PeriodicExpense.new(value: 1)])

      result = presenter.total_expenses

      expect(result).to eq(2)
    end
  end

end