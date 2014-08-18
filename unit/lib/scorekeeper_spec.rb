require './lib/scorekeeper.rb'

describe ScoreKeeper do
  describe "#average" do
    it "should raise exception" do
      scores = ScoreKeeper.new
      scores << 10 << 20 << 40
      scores.average.should == 23.333333333333332
    end
  end
end