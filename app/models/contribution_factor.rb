class ContributionFactor < ActiveRecord::Base
	validate :same_month

	private
	def same_month
	  	first_month_day = self.initial_date.beginning_of_month
	  	last_month_day = self.initial_date.end_of_month
	  	if ContributionFactor.where(:initial_date => first_month_day..last_month_day).any?
	  		errors.add(:initial_date, "can't be two in the same month")
	  	end
	end
end