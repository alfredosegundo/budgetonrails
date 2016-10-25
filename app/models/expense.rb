require "description_formater"

class Expense < ActiveRecord::Base
  validates :value, numericality: { greater_than: 0 }
  validates :description, :budget_date, :value, presence: true
  belongs_to :contributor
  before_save :set_buget_date_to_midnight
  belongs_to :expected_expense
  belongs_to :category

  def truncated_description
    DescriptionFormater.truncate(description)
  end

  def self.get_expenses_same_month_of date
    first_day_month = date.beginning_of_month
    last_day_month = date.end_of_month
    Expense.where(:budget_date => first_day_month..last_day_month)
  end

  def self.get_expenses_sum_for date
    get_expenses_same_month_of(date).sum(:value)
  end
  
  def formated_budget_date
    budget_date.strftime("%B %Y")
  end

  def set_buget_date_to_midnight
    self.budget_date = self.budget_date.midnight
  end
end
