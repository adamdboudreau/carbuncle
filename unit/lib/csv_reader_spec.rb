require './lib/csv_reader.rb'

describe CsvReader do
  describe ".new" do
    it "should set the filename given" do
      reader = CsvReader.new("fileTest")
      reader.filename.should == "fileTest"
    end
  end

  describe "#exist" do
    it "should be true if file exists" do
      reader = CsvReader.new("unit/tmp/test.txt")
      reader.exist?.should == true
    end

    it "should be false if file doesn't exist" do
      reader = CsvReader.new("test42.txt")
      reader.exist?.should == false
    end
  end

  describe "#read_lines" do
    it "should raise error if file doesn't exist" do
      reader = CsvReader.new("test42.txt")
      expect{ reader.read_lines }.to raise_exception(Errno::ENOENT)
    end

    it "should return an array of the text" do
      reader = CsvReader.new("unit/tmp/test.txt")
      results = reader.read_lines
      results.kind_of?(Array).should == true
      results.length.should == 1
      results.first.should == "test"
    end

    it "should return an array of the csv" do
      reader = CsvReader.new("unit/tmp/test.csv")
      results = reader.read_lines
      results.kind_of?(Array).should == true
      results.length.should == 2
      results.first.chomp.should == "test1, test2, test3"
      results[1].chomp.should == "test4, test5, test6"
    end
  end
end