class CreateContributionFactor < ActiveRecord::Migration
  def change
    create_table :contribution_factors do |t|
      t.decimal :factor
      t.date :initial_date
    end
  end
end
