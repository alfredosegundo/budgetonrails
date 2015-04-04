class WelcomeController < ApplicationController
  skip_before_action :require_login, only: [:index]
    
  def index
    render layout: 'before_login' if not logged_in?
    redirect_to action: 'home' if logged_in?
  end

  def home
    now = DateTime.now
    budget_date = DateTime.new now.year, now.month, now.day, 0,0,0,"+00:00"
    load_values budget_date
  end

  def change_date
    budget_date = Date.new home_params["budget_date(1i)"].to_i, home_params["budget_date(2i)"].to_i, home_params["budget_date(3i)"].to_i
    load_values budget_date.to_datetime
    render 'home'
  end

  private

    def load_values budget_date
      @presenter = WelcomeHomePresenter.new budget_date: budget_date,
        expenses: Expense.get_expenses_same_month_of(budget_date),
        periodic_expenses: PeriodicExpense.get_expenses_for_month(budget_date),
        expected_expenses: ExpectedExpense.all,
        contributions: Contribution.get_contributions_for_month(budget_date),
        contribution_factor: ContributionFactor.find_for_month(budget_date)
    end

    def home_params
      params.require(:dashboard).permit(:budget_date)
    end
end
