require "bigdecimal"
require "monetico/loan"
require "monetico/version"

class Float
  def big; BigDecimal(self.to_s); end

  def round_to(x)
    (self * 10**x).ceil.to_f / 10**x
  end

  def round_down(x)
    if self >= 0 
      (self * 10**x).floor.to_f / 10**x
    else
      -((-self * 10**x).floor.to_f / 10**x)
    end
  end
end

module Monetico
  # Your code goes here...
end
