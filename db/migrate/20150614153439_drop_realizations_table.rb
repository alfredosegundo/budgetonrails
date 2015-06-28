class DropRealizationsTable < ActiveRecord::Migration
  def up
    drop_table :realizations
    add_column :expenses, :expected_expense_id, :integer
  end
  def down
    create_table :realizations, id: false do |t|
      t.belongs_to :expense, index: true
      t.belongs_to :expected_expense, index: true
    end
  end
end
