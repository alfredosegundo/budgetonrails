require 'rails_helper'

RSpec.describe Revenue, :type => :model do
  describe "entity validation" do
    any_date = DateTime.new(2015,8,8)
    context "for fields state" do
      it "should not allow amount to be 0" do
        saved = Revenue.new(amount: 0, description: "any", budget_date: any_date).save

        expect(saved).to be false
      end
      it "should not allow amount to be less than 0" do
        saved = Revenue.new(amount: -1, description: "any", budget_date: any_date).save

        expect(saved).to be false
      end
      it "description should not be empty" do
        saved = Revenue.new(amount: 1, description: "", budget_date: any_date).save

        expect(saved).to be false
      end
    end
  end
end
