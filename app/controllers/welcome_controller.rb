  class WelcomeController < ApplicationController
  skip_before_action :require_login, only: [:index]
    
  def index
    render layout: 'before_login'
  end

  def home
    now = DateTime.now
    budget_date = DateTime.new now.year, now.month, now.day, 0,0,0,"+00:00"
    load_values(budget_date)
  end

  def change_date
    budget_date = Date.new home_params["budget_date(1i)"].to_i, home_params["budget_date(2i)"].to_i, home_params["budget_date(3i)"].to_i
    load_values(budget_date.to_datetime)
    render 'home'
  end

  private

  def load_values(budget_date)
    @budget_date = budget_date
    @expenses = Expense.get_expenses_same_month_of(budget_date)
    @periodic_expenses = PeriodicExpense.get_expenses_for_month(budget_date)
    @total_expenses = sum_values(@expenses) + sum_values(@periodic_expenses)
    @contributions = Contribution.get_contributions_for_month(budget_date)
    @contribution_factor = ContributionFactor.find_for_month(budget_date).factor / 100
    @total_contributions = @contributions.map(&:amount).inject(0) { |sum, val| sum + val * @contribution_factor}
    @balance = @total_contributions - @total_expenses if @contribution_factor
  end

  def sum_values(entities)
    entities.map(&:value).inject(0, &:+)
  end
  
  def home_params
    params.require(:dashboard).permit(:budget_date)
  end
end
