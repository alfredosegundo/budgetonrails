class ExpectedExpense < ActiveRecord::Base
  validates :description, :value, presence: true
  has_many :realizations
  has_many :expenses, through: :realizations

  def self.not_realized_on date
    initial_date = date.beginning_of_month
    final_date = date.end_of_month
    ExpectedExpense.where("NOT expenses.budget_date between ? AND ? OR expenses IS NULL", initial_date, final_date).eager_load(:expenses)
  end
end