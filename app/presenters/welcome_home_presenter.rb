require "maths"

class WelcomeHomePresenter

  attr_reader :budget_date

  def initialize budget_date: nil, revenues: [], expenses: [], periodic_expenses: [], 
    expected_expenses: [], contributions: [], contribution_factor: {}
    @budget_date = budget_date
    @revenues = revenues
    @expenses = expenses
    @periodic_expenses = periodic_expenses
    @expected_expenses = expected_expenses
    @contributions = contributions
    @contribution_factor = contribution_factor
  end

  def category
    categories = Hash.new(0)
    @expenses.each do |expense|
      categories[expense.category.name] += expense.value
    end
    categories
  end

  def colors
    colors = Set.new
    @expenses.each do |expense|
      colors.add(expense.category.color)
    end
    colors
  end

  def balance
    return (total_contributions + total_revenues) - total_expenses
  end

  def total_contributions
    Maths.sum_multiplied_by @contributions, :amount, contribution_factor_multiplier
  end

  def contribution_factor_multiplier
    return self.contribution_factor / 100
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
    (Maths.sum expenses, :value) + (Maths.sum expected_expenses, :value)
  end

  def expenses
    return @periodic_expenses + @expenses if exist? @periodic_expenses, @expenses
    return @periodic_expenses if exist? @periodic_expenses
    return @expenses if exist? @expenses
    []
  end

  def expected_expenses
    return @expected_expenses if exist? @expected_expenses
    []
  end

  def formated_budget_date
    return @budget_date.strftime "%B %Y" if @budget_date
    ""
  end

  def revenues
    return @revenues if exist? @revenues
    []
  end

  def total_revenues
    Maths.sum @revenues, :amount
  end

  private
    def exist? *expenses
      expenses.all? {|e| e and not e.empty?}
    end
end
