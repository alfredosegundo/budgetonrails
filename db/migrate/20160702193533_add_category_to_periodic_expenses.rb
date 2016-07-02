class AddCategoryToPeriodicExpenses < ActiveRecord::Migration
  def change
    add_reference :periodic_expenses, :category, index: true, foreign_key: true
  end
end
