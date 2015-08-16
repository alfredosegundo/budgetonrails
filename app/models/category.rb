class Category < ActiveRecord::Base
	validates :name, :color, presence: true
	validates :color, length: { within: 4..7 }
	has_many :expense
	has_many :revenue
end
