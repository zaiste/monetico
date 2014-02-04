module Monetico
  class Loan
    include Excel

    CADENCE = {
      monthly: 12,
      weekly: 52,
    }

    # methods
    # <ex. capital_real> - rounded
    # <ex. capital_real_real> - float, used in internal calculations
    # <ex. calculate_capital> - calculate for the first time, float

    def initialize(amount, interest_rate, no_installments, cadence = :monthly, kind = :desc)
      @amount = amount.big
      @interest_rate = interest_rate.big / CADENCE[cadence]
      @no_installments = no_installments
      @kind = kind
    end

    private

    # Capital - amount / number of installments
    def capital
      round capital_real
    end

    public :capital

    def capital_real
      @capital = calculate_capital if @capital.nil?
      @capital
    end

    def calculate_capital
      @amount / @no_installments
    end

    # Total amount of interests
    def total_interests
      round total_interests_real
    end

    public :total_interests

    def total_interests_real
      @total_interests = calculate_total_interests if @total_interests.nil?
      @total_interests
    end

    def calculate_total_interests
      if const?
        par = (1 + @interest_rate) ** @no_installments
        payback_amount = @amount * @interest_rate * par / (par - 1)
        payback_amount * @no_installments - @amount
      else
        0.5.big * @interest_rate * @no_installments * (@amount + capital_real)
      end
    end

    # Interests for period/installment
    def interests(idx)
      round interests_real(idx)
    end

    public :interests

    def interests_real(idx)
      @interests = Array.new if @interests.nil?
      @interests[idx] = calculate_interests(idx) if @interests[idx].nil?
      @interests[idx]
    end

    # little refactoring
    alias_method :interests_for_period, :interests

    def calculate_interests(idx)
      if const?
        ipmt(@interest_rate, idx, @no_installments, @amount).abs
      else
        (@amount - (idx - 1) * capital_real) * @interest_rate
      end
    end

    # Monthly payment
    def monthly_payment
      round monthly_payment_real
    end

    public :monthly_payment

    def monthly_payment_real
      @monthly_payment = calculate_monthly_payment if @monthly_payment_float.nil?
      @monthly_payment
    end

    def calculate_monthly_payment
      pmt(@interest_rate, @no_installments, @amount).abs
    end

    # Capital for period
    def capital_for_period(idx)
      round capital_for_period_real(idx)
    end

    public :capital_for_period

    def capital_for_period_real(idx)
      # only for desc
      return capital_real if not const?

      # only for const
      @capitals = Array.new if @capitals.nil?
      @capitals[idx] = calculate_capital_for_period(idx) if @capitals[idx].nil?
      @capitals[idx]
    end

    def calculate_capital_for_period(idx)
      ppmt(@interest_rate, idx, @no_installments, @amount).abs
    end

    # Amount for period
    def amounts(idx)
      capital_for_period(idx) + interests(idx)
    end

    public :amounts

    def const?
      @kind == :const
    end

    public 'const?'

    # round money value
    def round(v)
      MoneyArray.money_round_value(v)
    end

    # Loan debug
    def to_s
      s = "Loan\n"
      table = payback_all
      table.each_with_index do |t, i|
        s += "#{t[:no]}: #{t[:amount].to_f};\t#{t[:balance].to_f};\t#{t[:capital].to_f};\t#{t[:interests].to_f}\n"
      end
      return s
    end

    public :to_s

    # Paybacks items
    # all payback items for all
    def calculate_payback
      from = 1
      to = @no_installments
      range = (from..to)

      current_amount = 0.0

      if const?
        par = (1 + @interest_rate) ** @no_installments

        res = range.map do |n|
          current_amount += monthly_payment_real
          { no: n, interests: interests(n), amount: monthly_payment_real, capital: capital_for_period(n), balance: @amount + total_interests_real - current_amount }
        end
      else
        res = range.map do |n|
          amount = capital_real + interests(n)
          current_amount += amount
          { no: n, interests: interests(n), amount: amount, capital: capital_real, balance: @amount + total_interests_real - current_amount }
        end
      end
      @paybacks = res
      @paybacks_round = round_paybacks(res)
    end

    def payback_real(range)
      calculate_payback if @paybacks.nil?
      @paybacks[range]
    end

    def payback(range)
      calculate_payback if @paybacks.nil?
      @paybacks_round[range]
    end

    def payback_all
      calculate_payback if @paybacks.nil?
      @paybacks_round
    end

    public :payback_all

    public :payback


    def round_paybacks(res)
      [:interests, :amount, :capital, :balance].each do |k|
        tmp = MoneyArray.factory(res.collect { |r| r[k] })
        tmp = tmp.money_round

        res.each_with_index do |r, i|
          r[k] = tmp[i]
        end

      end
      return res
    end


  end
end
