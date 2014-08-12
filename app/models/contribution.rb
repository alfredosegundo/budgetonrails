class Contribution < ActiveRecord::Base
  belongs_to :contributor
  validate :same_month_same_contributor

  def same_month_same_contributor
  	first_month_day = self.created_at.beginning_of_month
  	last_month_day = self.created_at.end_of_month
  	if Contribution.where(:contributor => self.contributor).where(:created_at => first_month_day..last_month_day).any?
  		errors.add(:created_at, "can't be two in the same month")
  	end
  end
end

