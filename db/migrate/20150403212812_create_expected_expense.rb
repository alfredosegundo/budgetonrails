class CreateExpectedExpense < ActiveRecord::Migration
  def change
    create_table :expected_expenses do |t|
      t.decimal :value
      t.string :description
    end
  end
end
