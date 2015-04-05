class CreateJoinTableExpenseExpectedExpense < ActiveRecord::Migration
  def change
    create_table :realizations, id: false do |t|
      t.belongs_to :expense, index: true
      t.belongs_to :expected_expense, index: true
    end
  end
end
