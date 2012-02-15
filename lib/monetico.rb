require "bigdecimal"
require "monetico/calculable"
require "monetico/loan"
require "monetico/version"

class Float
  include Monetico::Calculable
end

class BigDecimal
  include Monetico::Calculable
end

class Fixnum
  # usable for #big
  include Monetico::Calculable
end

module Monetico
end
