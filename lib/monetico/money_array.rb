module Monetico
  class MoneyArray < Array
    def money_round
      return self.class.money_round(self)
    end

    def array_sum
      self.inject(nil) { |sum, x| sum ? sum+x : x }
    end

    def self.factory(_from)
      obj = self.new
      _from.each do |f|
        obj << f
      end
      return obj
    end

    # round series of values to achieve proper sum
    def self.money_round(a)
      sum = a.array_sum
      rest = 0.0
      result = MoneyArray.new

      a.each do |b|
        rounded = ((b * 100).round / 100.0)
        real = b

        # compensation
        if rest >= 1.0
          rounded -= 1.0
          rest -= 1.0
        elsif rest <= -1.0
          rounded -= -1.0
          rest -= -1.0
        end

        result << rounded.to_big
        rest += real - rounded
      end

      # puts "rest #{rest}"
      return result

    end
  end
end