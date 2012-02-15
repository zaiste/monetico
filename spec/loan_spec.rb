require 'spec_helper'
require 'rspec'

describe Monetico::Loan do
  before :each do
  end

  it "should calculate loan" do
    amount = 1000.0
    interest_rate = 0.2
    number_of_installments = 3
    cadence = :weekly
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
