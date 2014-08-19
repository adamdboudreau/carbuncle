require './lib/playtime.rb'

describe Playtime do
  describe ".block_method" do
    it "should raise exception" do
      expect{ Playtime.block_method(2) { |a, b| a*b } }.to raise_exception(Playtime::ErrorCallingBlock)
    end

    it "should use the parameters given to call the block with" do
      Playtime.block_method(2, 4, 5) { |a, b| a.to_i*b.to_i }.should == 8
      Playtime.block_method(2, 5)    { |a, b| a.to_i*b.to_i }.should == 10
      Playtime.block_method(2)       { |a, b| a.to_i*b.to_i }.should == 0
      Playtime.block_method('test')  { |a, b| a*2 }.should == 'testtest'
    end
  end


  describe ".thread_test" do
    it "return stuff" do
      Playtime.thread_test.should == [1, 2, 3, 1, 2, 3]
    end
  end
end