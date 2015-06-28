class ExpectedExpense < ActiveRecord::Base
  validates :description, :value, :initial_date, presence: true
  before_save :adjust_dates
  has_many :expenses

  def adjust_dates
    self.initial_date = self.initial_date.beginning_of_month
    self.final_date = self.final_date.end_of_month
  end

  def self.not_realized_on date
    initial_date = date.beginning_of_month
    final_date = date.end_of_month
    in_this_month = ExpectedExpense.includes(:expenses)
                    .where(expenses: {budget_date: initial_date..final_date})
                    .to_a.map { |ee| ee.id }
    ExpectedExpense.where.not(id: in_this_month).where("initial_date <= :mydate AND final_date >= :mydate", {mydate: date})
  end
end
