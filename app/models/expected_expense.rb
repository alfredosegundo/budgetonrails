class ExpectedExpense < ActiveRecord::Base
  has_many :realizations
  has_many :expenses, through: :realizations
end