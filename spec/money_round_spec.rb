require "spec_helper"

describe Monetico::MoneyArray do
  describe "round simple array" do
    before :all do
    end

    it "should round simple array" do
      ma = Monetico::MoneyArray.new
      ma << 10.001
      ma << 9.999

      ma.money_round.each do |m|
        # precision check
        rest = (m * 100.00) % 1
        #puts "#{m} - rest #{rest}"
        rest.should == 0.0
      end

    end

    it "should round simple loan results" do
      ma = Monetico::MoneyArray.new
      # also testes using floats
      ma << BigDecimal.new("327.8389946270847")
      ma << BigDecimal.new("333.3029778708694")
      ma << BigDecimal.new("338.85802750205056")

      ma.money_round.each do |m|
        # precision check
        rest = (m * 100.00) % 1
        #puts "#{m} - rest #{rest}"
        rest.should == 0.0
      end

      # sum after rounding
      ma.money_round.array_sum.should == 1000.0
    end

  end
end

