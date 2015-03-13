require 'rails_helper'

RSpec.describe PeriodicExpense, :type => :model do
	context "entity validation" do
		it "should not save when description is empty" do
			any_date = DateTime.new 2015, 3, 12
			saved = PeriodicExpense.new(description: "", value: 1.0, start_date: any_date, end_date: any_date).save
			
			expect(saved).to eq(false)
		end

		it "should not save when value is less or equal to zero" do
			any_date = DateTime.new 2015, 3, 12
			saved = PeriodicExpense.new(description: "any", value: 0.0, start_date: any_date, end_date: any_date).save
			
			expect(saved).to eq(false)
		end
	end
end