class PeriodicExpense < ActiveRecord::Base
	validates :description, :start_date, :end_date, presence: true
	validates :value, numericality: { greater_than: 0 }
	before_save :set_dates_to_edges_of_month
	belongs_to :category

  def truncated_description
    self.description[0..20]
  end

	def self.get_expenses_for_month(date)
		PeriodicExpense.eager_load(:category).where("start_date <= ?", date).where("end_date >= ?", date)
	end

  def installment_cycles
    return 0 if self.start_date > self.end_date
    1 + (self.end_date.year * 12 + self.end_date.month) - (self.start_date.year * 12 + self.start_date.month)
  end

  def current_installment(date)
    return 0 if date < self.start_date
    return self.installment_cycles if date > self.end_date
    1 + (date.year * 12 + date.month) - (self.start_date.year * 12 + self.start_date.month)
  end

	private
		def set_dates_to_edges_of_month
			self.end_date = self.end_date.end_of_month
			self.start_date = self.start_date.beginning_of_month
		end
end
