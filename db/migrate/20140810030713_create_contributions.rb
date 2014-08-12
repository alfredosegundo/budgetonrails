class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.decimal :amount
      t.references :contributor, index: true

      t.datetime :created_at
    end
  end
end
