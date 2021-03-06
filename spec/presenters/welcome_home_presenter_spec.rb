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

    it "should return sum of all expected_expenses provided" do
      presenter = WelcomeHomePresenter.new(expected_expenses: [ExpectedExpense.new(value: 1)])

      result = presenter.total_expenses

      expect(result).to eq(1)
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

    it "should be the difference between contributions plus revenue and expenses" do
      presenter = WelcomeHomePresenter.new(
        contributions: [Contribution.new(amount: 1)],
        expenses: [Expense.new(value: 1)],
        revenues: [Revenue.new(amount: 1)],
        contribution_factor: ContributionFactor.new(factor: 100))

      result = presenter.balance

      expect(result).to eq 1
    end
  end

  describe "#contributions" do
    it "should return empty array if contributions are nil" do
      presenter = WelcomeHomePresenter.new contributions: nil

      result = presenter.contributions

      expect(result).to be_instance_of(Array)
      expect(result.size).to eq 0
    end

    it "should return an array with contributions provided" do
      presenter = WelcomeHomePresenter.new(contributions: [Contribution.new(amount: 1)])

      result = presenter.contributions

      expect(result.size).to eq 1
    end
  end

  describe "#total_revenues" do
    it "should return zero when there is no revenues" do
      presenter = WelcomeHomePresenter.new revenues: []

      result = presenter.total_revenues

      expect(result).to eq 0
    end

    it "should return the sum of revenues it has" do
      presenter = WelcomeHomePresenter.new revenues: [Revenue.new(amount:1)]

      result = presenter.total_revenues

      expect(result).to eq 1
    end
  end

  describe '#categories' do
    it 'should list categories from expenses' do
      any_category = Category.new(name: 'cat', color: 'any')
      expense_with_category = Expense.new(description: 'any', value: 1.0, budget_date: DateTime.now, category: any_category)
      presenter = WelcomeHomePresenter.new expenses: [expense_with_category]

      categories = presenter.categories

      expect(categories['cat']).to eq 1
    end

    it 'should also list categories from periodic expenses' do
      any_category = Category.new(name: 'cat', color: 'any')
      expense_with_category = PeriodicExpense.new(description: 'any', value: 1.0, category: any_category)
      presenter = WelcomeHomePresenter.new periodic_expenses: [expense_with_category]

      categories = presenter.categories

      expect(categories['cat']).to eq 1
    end

    it 'should sum expenses and periodic expenses categories' do
      any_category = Category.new(name: 'cat', color: 'any')
      another_category = Category.new(name: 'cat2', color: 'any')
      p_expense_with_category = PeriodicExpense.new(description: 'any', value: 1.0, category: any_category)
      p_expense_with_category2 = PeriodicExpense.new(description: 'any', value: 1.0, category: any_category)
      expense_with_category = Expense.new(description: 'any', value: 10.0, category: another_category)
      presenter = WelcomeHomePresenter.new periodic_expenses: [p_expense_with_category, p_expense_with_category2], expenses: [expense_with_category]

      categories = presenter.categories

      expect(categories['cat']).to eq 2
      expect(categories['cat2']).to eq 10
    end
  end

end