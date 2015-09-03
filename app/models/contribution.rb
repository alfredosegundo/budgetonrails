class Contribution < ActiveRecord::Base
  belongs_to :contributor
  validates :budget_date, :amount, presence: true
  validate :same_month_same_contributor

  def self.get_contributions_for_month(date)
    last_month_day = date.utc.end_of_month
    Contribution.select("DISTINCT ON (contributor_id) amount as amount, contributor_id as contributor_id, budget_date as budget_date, id as id")
                .where(["budget_date <= ?", last_month_day])
                .order(contributor_id: :asc, budget_date: :desc).to_a
  end

  private
  def same_month_same_contributor
    if self.budget_date and self.contributor
      self.budget_date = self.budget_date.midnight
    	first_month_day = self.budget_date.beginning_of_month
    	last_month_day = self.budget_date.end_of_month
    	if new_record? && Contribution.where(:contributor_id => self.contributor.id)
                     .where(:budget_date => first_month_day..last_month_day).any?
    		errors.add(:budget_date, "can't be two in the same month")
    	end
    end
  end
end
