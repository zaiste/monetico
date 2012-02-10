require 'spec_helper'
require 'rspec'

describe Monetico do
  before :each  do
  end

  it "should round up/down BigDecimal" do
    b = BigDecimal.new('1.0155')
    b.round_down(2).should == 1.01
    b.round_up(2).should == 1.02
    b.round_to(2).should == 1.02
    b.round_down.should == 1.01
    b.round_up.should == 1.02

    b.round_down(1).should == 1.0
    b.round_up(1).should == 1.1

    b.round_down(0).should == 1.0
    b.round_up(0).should == 2.0
  end

  it "should round up/down Float" do
    b = 1.0155
    b.round_down(2).should == 1.01
    b.round_up(2).should == 1.02
    b.round_to(2).should == 1.02
    b.round_down.should == 1.01
    b.round_up.should == 1.02

    b.round_down(1).should == 1.0
    b.round_up(1).should == 1.1

    b.round_down(0).should == 1.0
    b.round_up(0).should == 2.0
  end

end
