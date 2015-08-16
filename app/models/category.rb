class Category < ActiveRecord::Base
	has_many :expense
	has_many :revenue
end
