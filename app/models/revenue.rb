class Revenue < ActiveRecord::Base
	validates :amount, numericality: { greater_than: 0 }
	validates :description, presence: true

  def formated_budget_date
    budget_date.strftime("%B %Y")
  end
end
