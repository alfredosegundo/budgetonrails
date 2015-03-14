class PeriodicExpense < ActiveRecord::Base
	validates :description, :start_date, :end_date, presence: true
	validates :value, numericality: { greater_than: 0 }
	before_save :set_dates_to_edges_of_month

	def self.get_expenses_for_month(date)
		PeriodicExpense.where("start_date <= ?", date).where("end_date >= ?", date)
	end

	private
		def set_dates_to_edges_of_month
			self.end_date = self.end_date.end_of_month
			self.start_date = self.start_date.beginning_of_month
		end
end
