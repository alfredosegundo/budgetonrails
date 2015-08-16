class AddCategoryRefToRevenues < ActiveRecord::Migration
  def change
    add_reference :revenues, :category, index: true, foreign_key: true
  end
end
