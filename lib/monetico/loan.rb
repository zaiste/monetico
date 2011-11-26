module Monetico
  class Loan
    CADENCE = {
      monthly: 12,
      weekly: 52,
    }

    def initialize(amount, interest_rate, no_installments, cadence=:monthly, kind=:desc)
      @amount = amount.big
      @interest_rate = interest_rate.big / CADENCE[cadence] 
      @no_installments = no_installments
      @kind = kind
    end

    def capital 
      @amount / @no_installments
    end

    def total_interests
      if const?
        par = (1 + @interest_rate) ** @no_installments
        payback_amount = @amount * @interest_rate * par / (par - 1) 

        payback_amount * @no_installments - @amount 
      else
        0.5.big * @interest_rate * @no_installments * (@amount + capital)
      end
    end

    def interests(idx)
      (@amount - (idx - 1) * capital) * @interest_rate
    end

    def payback(range) 
      from = range.begin
      to = range.end

      if const?
        par = (1 + @interest_rate) ** @no_installments

        range.map do |n|
          { no: n, interests: interests(n), amount: @amount * @interest_rate * par / (par - 1) }
        end
      else
        range.map do |n|
          { no: n, interests: interests(n), amount: capital + interests(n) }
        end
      end 
    end

    def const?
      @kind == :const
    end
    private :const?

  end
end