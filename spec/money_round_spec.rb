require "spec_helper"

describe Monetico::MoneyArray do
  describe "round simple array" do
    before :all do
    end

    it "should round simple array" do
      ma = Monetico::MoneyArray.new
      ma << 10.001
      ma << 9.999
      puts ma.class

      ma.money_round.each do |m|
        # precision check
        rest = (m * 100.00) % 1
        puts "#{m} - rest #{rest}"
      end

    end

    it "should round simple loan results" do
      #344.50566129375136
      #16.666666666666668
      #327.8389946270847
      #689.0113225874981
      #*
      #344.50566129375136
      #11.20268342288194
      #333.3029778708694
      #344.5056612937467
      #*
      #344.50566129375136
      #5.647633791700789
      #338.85802750205056

      ma = Monetico::MoneyArray.new
      # also testes using floats
      ma << BigDecimal.new("327.8389946270847")
      ma << BigDecimal.new("333.3029778708694")
      ma << BigDecimal.new("338.85802750205056")

      puts ma.array_sum

      ma.money_round.each do |m|
        # precision check
        rest = (m * 100.00) % 1
        puts "#{m} - rest #{rest}"
      end

    end

  end
end

