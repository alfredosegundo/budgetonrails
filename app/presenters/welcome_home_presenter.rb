require "maths"

class WelcomeHomePresenter

  attr_reader :budget_date

  def initialize(budget_date: nil, expenses: [], periodic_expenses: [], contributions: [], contribution_factor: {})
    @budget_date = budget_date
    @expenses = expenses
    @periodic_expenses = periodic_expenses
    @contributions = contributions
    @contribution_factor = contribution_factor
  end

  def balance
    return total_contributions - total_expenses
  end

  def total_contributions
    Maths.sum_multiplied_by(@contributions, :amount, contribution_factor_multiplier)
  end

  def contribution_factor_multiplier
    return self.contribution_factor / 100
  end

  def contribution_factor
    return @contribution_factor.factor if @contribution_factor.respond_to? :factor
    0
  end

  def contributions
    @contributions
  end
  
  def total_expenses
    Maths.sum(expenses, :value)
  end

  def expenses
    return @periodic_expenses + @expenses if @periodic_expenses and @expenses and not @periodic_expenses.empty? and not @expenses.empty?
    return @periodic_expenses if @periodic_expenses and not @periodic_expenses.empty?
    return @expenses if @expenses and not @expenses.empty?
    []
  end

  def formated_budget_date
    return @budget_date.strftime("%B %Y") if @budget_date
    ""
  end

end
