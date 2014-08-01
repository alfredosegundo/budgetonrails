class CreateContributors < ActiveRecord::Migration
  def change
    create_table :contributors do |t|
      t.string :firstName
      t.string :lastName

      t.timestamps
    end
  end
end
