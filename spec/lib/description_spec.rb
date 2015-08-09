require 'rails_helper.rb'
require 'description_formater.rb'

RSpec.describe DescriptionFormater do
describe "description truncantion" do
  context "for empty string" do
    it "should return empty string" do
      result = DescriptionFormater.truncate("")

      expect(result).to eq ""
    end
  end

  context "for nil" do
  	it "should return empty string" do
      result = DescriptionFormater.truncate(nil)

      expect(result).to eq ""
  	end
  end

  context "for valid string" do
  	it "should return the string it self if less than 20 chars" do
      result = DescriptionFormater.truncate("1234567890123456789")

      expect(result).to eq "1234567890123456789"
  	end

  	it "should return truncated string at 20th char more than 20 chars" do
      result = DescriptionFormater.truncate("123456789012345678901")

      expect(result).to eq "12345678901234567890..."
  	end
  end
end
end