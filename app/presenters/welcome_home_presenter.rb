require "Maths"

class WelcomeHomePresenter

	def initialize(budget_date: nil, expenses: [], periodic_expenses: [], contributions: [], contribution_factor: {})
		@budget_date = budget_date
		@expenses = expenses
		@periodic_expenses = periodic_expenses
		@contributions = contributions
		@contribution_factor = contribution_factor
	end

	def total_expenses
		Maths.sum(expenses, :value)
	end

	def expenses
		return @periodic_expenses + @expenses if @periodic_expenses && @expenses && !@periodic_expenses.empty? && !@expenses.empty?
		return @periodic_expenses if @periodic_expenses && !@periodic_expenses.empty?
		return @expenses if @expenses && !@expenses.empty?
		[]
	end

	def budget_date
		return @budget_date.strftime("%B %Y") if @budget_date
		""
	end

end