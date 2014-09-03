class WelcomeController < ApplicationController
	skip_before_action :require_login, only: [:index]
	
	def index
		@total_expenses = Expense.get_expenses_for(Date.today)
	end
end
