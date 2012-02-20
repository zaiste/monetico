require "spec_helper"

describe Monetico::Loan do
  describe "const loan" do
    before :all do
      # tests were updated using
      # http://www.money.pl/banki/kalkulatory/kredytowy/
      @loan = Monetico::Loan.new(200000.0, 0.065, 360, :monthly, :const)
    end

    it "first monthly_payment" do
      @loan.monthly_payment.to_f.should == 1264.14
      @loan.monthly_payment.to_f.should == 1264.14
    end

    it "total_interests returns sum of interests" do
      @loan.total_interests.to_f.should == 255088.98
    end

    it "monthly_capital(1) returns capital for first payment" do
      @loan.capital_for_period(1).to_f.abs.should == 180.80
    end

    it "monthly_interests(1) returns capital for first payment" do
      @loan.interests_for_period(1).to_f.abs.should == 1083.33
    end

    it "monthly_capital(117) returns capital for payment" do
      @loan.capital_for_period(117).to_f.abs.should == 338.34
    end

    it "monthly_intersts(117) returns capital for payment" do
      @loan.interests_for_period(117).to_f.abs.should == 925.80
    end

    it "monthly_capital(231) returns capital for payment" do
      @loan.capital_for_period(231).to_f.abs.should == 626.33
    end

    it "monthly_intersts(231) returns capital for payment" do
      @loan.interests_for_period(231).to_f.abs.should == 637.81
    end

    # TODO
    it "payback_all returns payback table and last item balance should be 0.0" do
      #table = @loan.payback(1..360) # 1 or 0 should be the first payback item?
      table = @loan.payback_all

      #table.size.should == 360

      table[0][:capital].to_f.abs.should == 180.80
      table[0][:interests].to_f.abs.should == 1083.33
      #table[0][:amount].to_f.abs.should == 180.80
      #table[0][:balance].to_f.abs.should == 180.80


      #table.last[:capital].to_f.abs.should == 180.80
      #table.last[:interests].to_f.abs.should == 1083.33
      #table.last[:amount].to_f.abs.should == 180.80
      table.last[:balance].to_f.should == 0.0
    end

  end

  describe "desc loan" do
    before :all do
      @loan = Monetico::Loan.new(200000.0, 0.065, 360, :monthly, :desc)
    end

    it "capital returns amount/no_installments" do
      @loan.capital.to_f.abs.should == 555.56
    end

    it "total_interests returns sum of interests" do
      @loan.total_interests.to_f.should == 195541.67
    end

    it "interests(1) returns intersts for 1 payment" do
      @loan.interests(1).to_f.should == 1083.33
    end

    it "amount(1) returns amount for 1 payment" do
      @loan.amounts(1).to_f.should == 1638.89
    end

    it "interests(123) returns intersts for 1 payment" do
      @loan.interests(123).to_f.should == 716.20
    end

    it "amount(123) returns amount for 1 payment" do
      @loan.amounts(123).to_f.should == 1271.76
    end

    it "payback_all returns payback table and last item balance should be 0.0" do
      table = @loan.payback_all
      table[359][:balance].to_f.should == 0.0
    end

    it "can return debug string using to_s" do
      @loan.to_s.should be_kind_of(String)
    end

  end

end

