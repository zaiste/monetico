module Monetico
  module Calculable
    DEF_PREC = 2

    def big
      BigDecimal(self.to_s);
    end

    def round_to(x = DEF_PREC)
      (self * 10**x).ceil.to_f / 10**x
    end

    alias_method :round_up, :round_to

    def round_down(x = DEF_PREC)
      if self >= 0
        (self * 10**x).floor.to_f / 10**x
      else
        -((-self * 10**x).floor.to_f / 10**x)
      end
    end
  end
end