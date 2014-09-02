class Contributor < ActiveRecord::Base
	has_many :contributions, dependent: :destroy
	has_many :expenses
	validates :firstName, :lastName, presence: true, length: { minimum: 1 }
	validates :email, presence: true, confirmation: true, uniqueness: { case_sensitive: false }
  	validates :email_confirmation, presence: true, on: :create
end
