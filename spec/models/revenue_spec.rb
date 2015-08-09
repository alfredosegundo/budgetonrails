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

  describe "instance method" do
    context "get_for_month" do
      budget_date = DateTime.new(2015,8,8)
      it "should return 0 when there is no revenues in a especific month" do
        revenues = Revenue.get_for_month(budget_date)

        expect(revenues.count).to eq 0
      end

      it "should return sum of all revenues in a month" do
        Revenue.new(description: "any", amount: 1, budget_date: budget_date).save
        revenues = Revenue.get_for_month(budget_date)

        expect(revenues.count).to eq 1
      end

      it "should return sum of all revenues in a especific month" do
        Revenue.new(description: "any", amount: 1, budget_date: DateTime.new(2015,7,30)).save
        Revenue.new(description: "any", amount: 1, budget_date: budget_date).save
        revenues = Revenue.get_for_month(budget_date)

        expect(revenues.count).to eq 1
      end
    end
  end
end
