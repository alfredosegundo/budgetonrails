  class WelcomeController < ApplicationController
  skip_before_action :require_login, only: [:index]
    
  def index
    render layout: 'before_login'
  end

  def home
    now = DateTime.now
    @expenses = Expense.get_expenses_same_month_of(now.utc)
    @total_expenses = @expenses.map(&:value).inject(0, &:+)
    @contributions = Contribution.get_contributions_for_month(now)
    @contribution_factor = ContributionFactor.find_for_month(now).factor / 100
    @total_contributions = @contributions.map(&:amount).inject(0) { |sum, val| sum + val * @contribution_factor}
    @balance = (@total_contributions*(@contribution_factor)) - @total_expenses if @contribution_factor
  end
end
