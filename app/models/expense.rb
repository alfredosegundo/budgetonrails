class Expense < ActiveRecord::Base
  belongs_to :contributor

  def formated_budget_date
  	budget_date.strftime("%B %Y")
  end
end
