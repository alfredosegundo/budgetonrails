require 'rails_helper.rb'

RSpec.describe WelcomeHomePresenter do

  describe "#formated_budget_date" do
    it "should return empty string for invalid date" do
      presenter = WelcomeHomePresenter.new(budget_date: nil)

      budget_date = presenter.formated_budget_date

      expect(budget_date).to eq("")
    end

    it "should return month and year for a date" do
      presenter = WelcomeHomePresenter.new(budget_date: DateTime.new(2015,1,1))

      budget_date = presenter.formated_budget_date

      expect(budget_date).to eq("January 2015")
    end
  end

  describe "#expenses" do

    it "should return an empty array if no expenses provided" do
      presenter = WelcomeHomePresenter.new

      expenses = presenter.expenses

      expect(expenses).to be_instance_of(Array)
      expect(expenses.size).to eq(0)
    end

    it "should return an array of expenses only if expenses provided" do
      presenter = WelcomeHomePresenter.new(expenses: [Expense.new])

      expenses = presenter.expenses

      expect(expenses.size).to eq(1)
      expect(expenses.first).to be_instance_of(Expense)
    end

    it "should return a merged array of expenses and periodic_expenses when both provied" do
      presenter = WelcomeHomePresenter.new(expenses: [Expense.new], periodic_expenses: [PeriodicExpense.new])

      expenses = presenter.expenses

      expect(expenses.size).to eq(2)
      expect(expenses.first).to be_instance_of(PeriodicExpense)
      expect(expenses.last).to be_instance_of(Expense)
    end

    it "should return an array of expenses if periodic_expenses are nil" do
      presenter = WelcomeHomePresenter.new(expenses: [Expense.new], periodic_expenses: nil)

      expenses = presenter.expenses

      expect(expenses.size).to eq(1)
      expect(expenses.first).to be_instance_of(Expense)
    end

    it "should return an array of periodic_expenses if expenses are nil" do
      presenter = WelcomeHomePresenter.new(expenses: nil, periodic_expenses: [PeriodicExpense.new])

      expenses = presenter.expenses

      expect(expenses.size).to eq(1)
      expect(expenses.first).to be_instance_of(PeriodicExpense)
    end

    it "should return an empty array if both periodic_expenses and expenses are nil" do
      presenter = WelcomeHomePresenter.new(expenses: nil, periodic_expenses: nil)

      expenses = presenter.expenses

      expect(expenses.size).to eq(0)
    end

    it "should return an empty array if expected_expenses, periodic_expenses and expenses are empty" do
      presenter = WelcomeHomePresenter.new(expenses: [], periodic_expenses: [], expected_expenses: [])

      expenses = presenter.expenses

      expect(expenses.size).to eq(0)
    end

    it "should return an array of expected_expenses only if expected_expenses provided" do
      presenter = WelcomeHomePresenter.new(expected_expenses: [ExpectedExpense.new])

      expenses = presenter.expenses

      expect(expenses.size).to eq(1)
      expect(expenses.first).to be_instance_of(ExpectedExpense)
    end

    it "should return an merged array of expected_expenses and periodic_expenses when both provided" do
      presenter = WelcomeHomePresenter.new(expected_expenses: [ExpectedExpense.new], periodic_expenses: [PeriodicExpense.new])

      expenses = presenter.expenses

      expect(expenses.size).to eq(2)
      expect(expenses.first).to be_instance_of(ExpectedExpense)
      expect(expenses.last).to be_instance_of(PeriodicExpense)
    end

    it "should return an merged array of expected_expenses and expenses when both provided" do
      presenter = WelcomeHomePresenter.new(expected_expenses: [ExpectedExpense.new], expenses: [Expense.new])

      expenses = presenter.expenses

      expect(expenses.size).to eq(2)
      expect(expenses.first).to be_instance_of(ExpectedExpense)
      expect(expenses.last).to be_instance_of(Expense)
    end
    it "should return an merged array of expected_expenses, periodic_expenses and expenses when provided" do
      presenter = WelcomeHomePresenter.new(expected_expenses: [ExpectedExpense.new], periodic_expenses: [PeriodicExpense.new], expenses: [Expense.new])

      expenses = presenter.expenses

      expect(expenses.size).to eq(3)
      expect(expenses.first).to be_instance_of(ExpectedExpense)
      expect(expenses.second).to be_instance_of(PeriodicExpense)
      expect(expenses.last).to be_instance_of(Expense)
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

  describe "#contribution_factor" do
    it "should return 0 when not initialized" do
      presenter = WelcomeHomePresenter.new

      result = presenter.contribution_factor

      expect(result).to eq 0
    end

    it "should return the initilized contribution factor" do
      presenter = WelcomeHomePresenter.new contribution_factor: ContributionFactor.new(factor: 1)

      result = presenter.contribution_factor
      
      expect(result).to eq 1
    end
  end

  describe "#contribution_factor_multiplier" do
    it "should be 0 when contribution_factor is empty" do
      presenter = WelcomeHomePresenter.new

      result = presenter.contribution_factor_multiplier

      expect(result).to eq 0
    end

    it "should be decimal mutiplier of contribution_factor percentage" do
      presenter = WelcomeHomePresenter.new(contribution_factor: ContributionFactor.new(factor: 100))

      result = presenter.contribution_factor_multiplier

      expect(result).to eq 1
    end

    it "should preserve two decimal cases from contribution_factor" do
      presenter = WelcomeHomePresenter.new(contribution_factor: ContributionFactor.new(factor: 99))

      result = presenter.contribution_factor_multiplier

      expect(result).to eq 0.99
    end
  end

  describe "#total_contributions" do
    it "should be 0 when contributions are empty" do
      presenter = WelcomeHomePresenter.new

      result = presenter.total_contributions

      expect(result).to eq 0
    end

    it "should sum all contributions and apply contribution_factor_multiplier" do
      presenter = WelcomeHomePresenter.new(contributions: [Contribution.new(amount: 100)],
        contribution_factor: ContributionFactor.new(factor: 50))

      result = presenter.total_contributions

      expect(result).to eq 50
    end
  end

  describe "#balance" do
    it "should be 0 when empty contributions and empty expenses" do
      presenter = WelcomeHomePresenter.new

      result = presenter.balance

      expect(result).to eq 0
    end

    it "should be the difference between total_contributions and total_expenses" do
      presenter = WelcomeHomePresenter.new(contributions: [Contribution.new(amount: 2)],
        expenses: [Expense.new(value: 1)], contribution_factor: ContributionFactor.new(factor: 100))

      result = presenter.balance

      expect(result).to eq 1
    end
  end
end