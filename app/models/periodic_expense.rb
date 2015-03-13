class PeriodicExpense < ActiveRecord::Base
	validates :description, :start_date, :end_date, presence: true
	validates :value, numericality: { greater_than: 0 }
end
