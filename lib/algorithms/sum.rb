class Sum
  attr_accessor :numbers

  def initialize(numbers)
    @numbers = numbers
    p "Numbers given: " + numbers.to_s
    p "Sum: " + sum(@numbers, @numbers.length).to_s
  end

  def sum(nums, n)
    if n == 1
      nums[0]
    else
      sum(nums, n - 1) + nums[n - 1]
    end
  end
end

Sum.new([2,2,2])
Sum.new([1,2,3])
Sum.new([4,4,4,4])