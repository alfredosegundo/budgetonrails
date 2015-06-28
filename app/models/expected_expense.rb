class ExpectedExpense < ActiveRecord::Base
  validates :description, :value, presence: true
  has_many :expenses

  def self.not_realized_on date
    initial_date = date.beginning_of_month
    final_date = date.end_of_month
    in_this_month = ExpectedExpense.includes(:expenses)
                    .where(expenses: {budget_date: initial_date..final_date})
                    .to_a.map { |ee| ee.id }
    ExpectedExpense.where.not(id: in_this_month)
  end
end
