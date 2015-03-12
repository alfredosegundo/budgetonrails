class CreatePeriodicExpenses < ActiveRecord::Migration
  def change
    create_table :periodic_expenses do |t|
      t.string :description
      t.decimal :value
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
