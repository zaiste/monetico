module Monetico
  class Loan
    include Excel
    
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
      if const?
        interests_for_period(idx)
      else
        (@amount - (idx - 1) * capital) * @interest_rate
      end
    end

    def payback(range) 
      from = range.begin
      to = range.end
      
      current_amount = 0.0
      
      if const?
        par = (1 + @interest_rate) ** @no_installments
                
        res = range.map do |n|
          current_amount += monthly_payment
          { no: n, interests: interests(n), amount: monthly_payment, capital: capital_for_period(n), balance:  @amount + total_interests - current_amount}
        end

        res = round_calculation(res)
        return res
      else
        res = range.map do |n|
          amount = capital + interests(n)
          current_amount += amount
          { no: n, interests: interests(n), amount: amount, capital: capital, balance: @amount + total_interests - current_amount}
        end
        
        res = round_calculation(res)
        return res
      end 
    end

    # all payback items for all
    def payback_all
      payback(1..@no_installments)
    end

    def round_calculation(res)
      [:interests, :amount, :capital, :balance].each do |k|
        tmp = MoneyArray.factory( res.collect{|r| r[k]} )
        tmp = tmp.money_round

        puts tmp.to_yaml

        res.each_with_index do |r,i|
          r[k] = tmp[i]
        end

      end
      return res
    end

    # not rounded
    def monthly_payment_float
      pmt(@interest_rate, @no_installments, @amount).abs  
    end

    # rounded
    def monthly_payment
      MoneyArray.money_round_value(monthly_payment_float)
    end

    # not rounded
    def interests_for_period_float(n)
      ipmt(@interest_rate, n, @no_installments, @amount).abs
    end

    # rounded
    def interests_for_period(n)
      MoneyArray.money_round_value(interests_for_period_float(n))
    end
    
    def capital_for_period_float(n)
      ppmt(@interest_rate, n, @no_installments, @amount).abs
    end

    def capital_for_period(n)
      MoneyArray.money_round_value(capital_for_period_float(n))
    end
           
    def const?
      @kind == :const
    end
    private :const?
  end
end
