class WelcomeController < ApplicationController
	skip_before_action :require_login, only: [:index]
	
	def index
	  	first_day_month = Date.today.beginning_of_month
		last_day_month = Date.today.end_of_month
		@total_expenses = Expense.where(:budget_date => first_day_month..last_day_month).sum(:value)
	end
end
