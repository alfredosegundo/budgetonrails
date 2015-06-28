class AddInitialDateAndFinalDateToExpectedExpense < ActiveRecord::Migration
  def change
    add_column :expected_expenses, :initial_date, :date
    add_column :expected_expenses, :final_date, :date
  end
end
