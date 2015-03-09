class ContributionFactor < ActiveRecord::Base
	validate :same_month, :max_factor_value

	def self.find_for_month(date)
	  	last_month_day = date.end_of_month
		ContributionFactor.where("initial_date <= ?", last_month_day).order(initial_date: :desc).first
	end

	private
	def same_month
	  	first_month_day = self.initial_date.beginning_of_month
	  	last_month_day = self.initial_date.end_of_month
	  	if new_record? && ContributionFactor.where(:initial_date => first_month_day..last_month_day).any?
	  		errors.add(:initial_date, "can't be two in the same month")
	  	end
	end

	def max_factor_value
		if self.factor > 100.0
	  		errors.add(:factor, "max value is 100.")
	  	end
	end
end