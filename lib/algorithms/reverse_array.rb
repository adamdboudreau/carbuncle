class ReverseArray
  attr_accessor :array

  def initialize(array)
    @array = array
    p "Array: " + array.to_s
    reversed = reverse @array, 0, @array.length - 1
    p "Reversed: " + reversed.to_s
  end

  def reverse(array, i, j)
    if i < j
      #swap a[i] & a[j]
      p array.inspect
      p "Swapping the indexes of => i: #{i}, j: #{j}"
      first = array[i]
      array[i] = array[j]
      array[j] = first
      p array.inspect
      reverse(array, i + 1, j - 1)
    end

    array
  end
end
ReverseArray.new([1,2,3,4,5])
p ""
ReverseArray.new([4,3,7])