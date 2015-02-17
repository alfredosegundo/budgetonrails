  class WelcomeController < ApplicationController
  skip_before_action :require_login, only: [:index]
    
  def index
    render layout: 'before_login'
  end

  def home
    @expenses = Expense.get_expenses_same_month_of(DateTime.now.utc)
    @total_expenses = @expenses.map(&:value).inject(0, &:+)
    @contributions = Contribution.get_contributions_for_month(DateTime.now)
    @total_contributions = @contributions.map(&:amount).inject(0, &:+)
  end
end
