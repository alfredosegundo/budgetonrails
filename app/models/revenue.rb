class Revenue < ActiveRecord::Base
	validates :amount, numericality: { greater_than: 0 }
	validates :description, presence: true
  belongs_to :category

  def truncated_description
    self.description[0..20]
  end

	def self.get_for_month date
    first_day_month = date.beginning_of_month
    last_day_month = date.end_of_month
    Revenue.where(:budget_date => first_day_month..last_day_month)
	end

  def formated_budget_date
    budget_date.strftime("%B %Y")
  end
end
