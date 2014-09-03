class Expense < ActiveRecord::Base
  belongs_to :contributor

  def self.get_expenses_for(budget_date)
    first_day_month = budget_date.beginning_of_month
    last_day_month = budget_date.end_of_month
    Expense.where(:budget_date => first_day_month..last_day_month).sum(:value)
  end
  
  def formated_budget_date
    budget_date.strftime("%B %Y")
  end
end
