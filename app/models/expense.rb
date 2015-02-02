class Expense < ActiveRecord::Base
  belongs_to :contributor
  before_save :move_dates_to_utc

  def self.get_expenses_same_month_of(date)
    first_day_month = date.beginning_of_month
    last_day_month = date.end_of_month
    Expense.where(:budget_date => first_day_month..last_day_month)
  end

  def self.get_expenses_sum_for(date)
    get_expenses_same_month_of(date).sum(:value)
  end
  
  def formated_budget_date
    budget_date.strftime("%B %Y")
  end

  def move_dates_to_utc
    self.budget_date = self.budget_date.midnight
  end
end
