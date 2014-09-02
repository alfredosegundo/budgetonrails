class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :description
      t.decimal :value
      t.timestamp :budget_date
      t.references :contributor, index: true

      t.timestamps
    end
  end
end
