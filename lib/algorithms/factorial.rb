class Factorial
  class << self
    def recursive(n)
      Factorial.validateNumber(n)
      return 1 if n == 0
      return n * Factorial.recursive(n - 1)
    end

    def countDown(n)
      Factorial.validateNumber(n)

      result = 1
      n.downto(1).each do |i|
        result ||= 1
        result *= i
      end
      result
    end

    def validateNumber(n)
      raise ArgumentError, "Integer required" if !n.is_a? Fixnum || !n.integer?
    end
  end
end


p "Factorial.recursive..."
test = Factorial.recursive 0
p "0 = #{test}"
test = Factorial.recursive(1)
p "1 = #{test}"
test = Factorial.recursive 2
p "2 = #{test}"
test = Factorial.recursive 3
p "3 = #{test}"
test = Factorial.recursive 4
p "4 = #{test}"
test = Factorial.recursive 5
p "5 = #{test}"

p "Factorial.countDown..."
test = Factorial.countDown 0
p "0 = #{test}"
test = Factorial.countDown(1)
p "1 = #{test}"
test = Factorial.countDown 2
p "2 = #{test}"
test = Factorial.countDown 3
p "3 = #{test}"
test = Factorial.countDown 4
p "4 = #{test}"
test = Factorial.countDown 5
p "5 = #{test}"