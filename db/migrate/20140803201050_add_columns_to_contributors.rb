class AddColumnsToContributors < ActiveRecord::Migration
  def change
    add_column :contributors, :email, :string
  end
end
