class Realization < ActiveRecord::Base
  belongs_to :expense
  belongs_to :expected_expense
end