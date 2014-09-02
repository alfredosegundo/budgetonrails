class Expense < ActiveRecord::Base
  belongs_to :contributor
end
