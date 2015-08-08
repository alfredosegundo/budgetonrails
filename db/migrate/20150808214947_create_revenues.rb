class CreateRevenues < ActiveRecord::Migration
  def change
    create_table :revenues do |t|
      t.string :description
      t.decimal :amount
      t.datetime :budget_date

      t.timestamps
    end
  end
end
