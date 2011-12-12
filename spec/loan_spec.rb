require "spec_helper"

describe Monetico::Loan do
  describe "const loan" do
    before :all do
      @loan = Monetico::Loan.new(200000.0, 0.065, 360, :monthly, :const)
    end
    
    it "capital returns amount/no_installments" do
      @loan.monthly_payment.to_f.round_down(2).abs.should == 1264.13
    end
    
    it "total_interests returns sum of interests" do
      @loan.total_interests.to_f.round_down(2).should == 255088.98
    end
            
    it "monthly_capital(1) returns capital for first payment" do
      @loan.capital_for_period(1).to_f.round_down(2).abs.should == 180.80
    end
    
    it "monthly_intersts(1) returns capital for first payment" do
      @loan.interests_for_period(1).to_f.round_down(2).abs.should == 1083.33
    end
    
    it "monthly_capital(117) returns capital for first payment" do
      @loan.capital_for_period(117).to_f.round_down(2).abs.should == 338.34
    end
    
    it "monthly_intersts(117) returns capital for first payment" do
      @loan.interests_for_period(117).to_f.round_down(2).abs.should == 925.80
    end
  
    it "payback(1..360) returns payback table and last item balance should be 0.0" do
      table =  @loan.payback(1..360)
    
      table[359][:balance].to_f.round_down(2).should == 0.0
    end  
    
  end

  describe "desc loan" do
    before :all do
      @loan = Monetico::Loan.new(200000.0, 0.065, 360, :monthly, :desc)
    end
    
    it "capital returns amount/no_installments" do
      @loan.capital.to_f.round_down(2).abs.should == 555.56
    end
    
    it "total_interests returns sum of interests" do
      @loan.total_interests.to_f.round_down(2).should == 195541.67
    end
            
    it "interests(1) returns intersts for 1 payment" do
      @loan.interests(1).to_f.round_down(2).should ==  1083.33
    end
  
    it "payback(1..360) returns payback table and last item balance should be 0.0" do
      table =  @loan.payback(1..360)
    
      table[359][:balance].to_f.round_down(2).should == 0.0
    end      
  end
end

