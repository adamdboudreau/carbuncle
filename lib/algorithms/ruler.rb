class Ruler
  attr_reader :nInches, :majorLength

  def initialize(nInches = 1, majorLength = 2)
    @nInches = nInches
    @majorLength = majorLength
  end

  def draw
    drawOneTick @majorLength, 0
    (1..@nInches).each do |i|
      drawTicks(@majorLength - 1)
      drawOneTick @majorLength, i
    end
  end

  def drawOneTick(tickLength, tickLabel = nil)
    tickText = ""
    (0..tickLength).each do |i|
      tickText << "-"
    end

    if tickLabel.nil?
      drawOneTick(tickLength, -1)
    else
      tickText += " #{tickLabel}" if tickLabel >= 0
      p tickText, ""
    end
  end

  def drawTicks(tickLength)
    if tickLength > 0
      drawTicks(tickLength - 1)
      drawOneTick(tickLength)
      drawTicks(tickLength - 1)
    end
  end
end
p "Ruler 3x3"
r = Ruler.new(3, 3)
r.draw
p "Ruler 5x2"
r = Ruler.new(5, 2)
r.draw