class AddBudgetDateToContribution < ActiveRecord::Migration
  def change
  	add_column :contributions, :budget_date, :datetime
  end
end
