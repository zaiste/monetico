require "spec_helper"

describe Monetico::Loan do
  describe "const loan" do
    before :all do
      # tests were updated using
      # http://www.money.pl/banki/kalkulatory/kredytowy/
      @loan = Monetico::Loan.new(200000.0, 0.065, 360, :monthly, :const)
    end

    it "first monthly_payment" do
      @loan.monthly_payment.to_f.round_down(2).abs.should == 1264.14
      @loan.monthly_payment.to_f.round_down.abs.should == 1264.14
    end

    it "total_interests returns sum of interests" do
      @loan.total_interests.to_f.round_down(2).should == 255088.98
    end

    it "monthly_capital(1) returns capital for first payment" do
      @loan.capital_for_period(1).to_f.round_down(2).abs.should == 180.80
    end

    it "monthly_interests(1) returns capital for first payment" do
      @loan.interests_for_period(1).to_f.round_down(2).abs.should == 1083.33
    end

    it "monthly_capital(117) returns capital for payment" do
      @loan.capital_for_period(117).to_f.round_down(2).abs.should == 338.34
    end

    it "monthly_intersts(117) returns capital for payment" do
      @loan.interests_for_period(117).to_f.round_down(2).abs.should == 925.80
    end

    it "monthly_capital(231) returns capital for payment" do
      @loan.capital_for_period(231).to_f.round_down(2).abs.should == 626.33
    end

    it "monthly_intersts(231) returns capital for payment" do
      @loan.interests_for_period(231).to_f.round_down(2).abs.should == 637.81
    end

    #it "payback(1..360) returns payback table and last item balance should be 0.0" do
    #  table = @loan.payback(1..360)
    #
    #  table[359][:balance].to_f.round_down(2).should == 0.0
    #end

  end

  #describe "desc loan" do
  #  before :all do
  #    @loan = Monetico::Loan.new(200000.0, 0.065, 360, :monthly, :desc)
  #  end
  #
  #  it "capital returns amount/no_installments" do
  #    @loan.capital.to_f.round_down(2).abs.should == 555.56
  #  end
  #
  #  it "total_interests returns sum of interests" do
  #    @loan.total_interests.to_f.round_down(2).should == 195541.67
  #  end
  #
  #  it "interests(1) returns intersts for 1 payment" do
  #    @loan.interests(1).to_f.round_down(2).should == 1083.33
  #  end
  #
  #  it "payback(1..360) returns payback table and last item balance should be 0.0" do
  #    table = @loan.payback(1..360)
  #
  #    table[359][:balance].to_f.round_down(2).should == 0.0
  #  end
  #
  #end

  it "should calculate loan" do
    amount = 1000.0
    interest_rate = 0.2
    number_of_installments = 3
    #cadence = :weekly
    cadence = :monthly
    kind = :const
    #kind = :desc

    loan_calc = Monetico::Loan.new(amount, interest_rate, number_of_installments, cadence, kind)
    puts loan_calc.to_yaml

    loan_calc.payback(1..number_of_installments).each do |l|
      #puts lo_nu.inspect
      puts l[:amount].to_f
      puts l[:interests].to_f
      puts l[:capital].to_f
      puts l[:balance].to_f
      puts "*"
      #payback_items.create(
      #  number: lo_nu[:no],
      #  pay_day: created_at + lo_nu[:no].send(period),
      #  interests: lo_nu[:interests],
      #  capital: lo_nu[:capital],
      #  balance: lo_nu[:balance]
      #)
    end
  end

end

