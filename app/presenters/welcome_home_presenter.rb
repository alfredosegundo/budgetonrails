require 'maths'

class WelcomeHomePresenter

  attr_reader :budget_date, :periodic_expenses, :expected_expenses, :expenses, :revenues

  def initialize(budget_date: nil, revenues: [], expenses: [], periodic_expenses: [],
                 expected_expenses: [], contributions: [], contribution_factor: {})
    @budget_date = budget_date
    @revenues = revenues
    @expenses = expenses
    @periodic_expenses = periodic_expenses
    @expected_expenses = expected_expenses
    @contributions = contributions
    @contribution_factor = contribution_factor
  end

  def categories
    categories = Hash.new(0)
    expenses_with_category.each do |expense|
      categories[expense.category.name] += expense.value if expense.category
    end
    categories
  end

  def all_expenses
    @expenses + @periodic_expenses + @expected_expenses
  end

  def colors
    colors = Set.new
    expenses_with_category.each do |expense|
      colors.add(expense.category.color) if expense.category
    end
    colors
  end

  def balance
    (total_contributions + total_revenues) - total_expenses
  end

  def total_contributions
    Maths.sum_multiplied_by @contributions, :amount, contribution_factor_multiplier
  end

  def contribution_factor_multiplier
    self.contribution_factor / 100
  end

  def contribution_factor
    return @contribution_factor.factor if @contribution_factor.respond_to? :factor
    0
  end

  def contributions
    return @contributions if @contributions
    []
  end
  
  def total_expenses
    (Maths.sum all_expenses, :value)
  end

  def formated_budget_date
    return @budget_date.strftime "%B %Y" if @budget_date
    ''
  end

  def total_revenues
    Maths.sum @revenues, :amount
  end

  private
    def exist? *expenses
      expenses.all? {|e| e and not e.empty?}
    end

    def expenses_with_category
      (@expenses + @periodic_expenses)
    end
end
