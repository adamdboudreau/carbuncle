require './lib/csv_writer.rb'
require './lib/csv_reader.rb'

describe CsvWriter do
  describe ".new" do
    it "should set the filename given" do
      writer = CsvWriter.new("newFile")
      writer.filename.should == "newFile"
    end
  end

  describe "#append_text" do
    it "should create the file and add the given text" do
      writer = CsvWriter.new("unit/tmp/appendtexttest.txt")
      writer.append_text("test")

      reader = CsvReader.new("unit/tmp/appendtexttest.txt")
      results = reader.read_lines
      results.last.chomp.should == "test"

      File.delete(File.expand_path("unit/tmp/appendtexttest.txt"))
    end

    context "file already exists" do
	    it "should append the text to the end of the file" do
	      open(File.expand_path("unit/tmp/appendtexttest2.txt"), 'w') { |f| f.puts "test1" }

	      writer = CsvWriter.new("unit/tmp/appendtexttest2.txt")
	      writer.append_text("test2")

	      reader = CsvReader.new("unit/tmp/appendtexttest2.txt")
	      results = reader.read_lines
	      results.length.should == 2
	      results.last.chomp.should == "test2"
	    end
	end
  end

  describe "#append_lines" do
    it "should create the file and add each of the lines" do
      writer = CsvWriter.new("unit/tmp/appendlinetest.csv")
      writer.append_lines(["test", "testing 2", "testing 3, testing 4"])

      reader = CsvReader.new("unit/tmp/appendlinetest.csv")
      results = reader.read_lines
      results.length.should == 3
      results.first.chomp.should == "test"
      results.last.chomp.should == "testing 3, testing 4"

      File.delete(File.expand_path("unit/tmp/appendlinetest.csv"))
    end

    context "file already exists" do
	    it "should append each line to the end of the file" do
	      open(File.expand_path("unit/tmp/appendlinetest2.csv"), 'w') { |f| f.puts "test1" }

	      writer = CsvWriter.new("unit/tmp/appendlinetest2.csv")
	      writer.append_lines(["test2", "test3"])

	      reader = CsvReader.new("unit/tmp/appendlinetest2.csv")
	      results = reader.read_lines
	      results.length.should == 3
	      results.first.chomp.should == "test1"
	      results[1].chomp.should == "test2"
	      results.last.chomp.should == "test3"
	    end
	end
  end

  # describe "#read_lines" do
  #   it "should raise error if file doesn't exist" do
  #     writer = CsvWriter.new("test42.txt")
  #     expect{ writer.read_lines }.to raise_exception(Errno::ENOENT)
  #   end

  #   it "should return an array of the text" do
  #     writer = CsvWriter.new("unit/tmp/test.txt")
  #     results = writer.read_lines
  #     results.kind_of?(Array).should == true
  #     results.length.should == 1
  #     results.first.should == "test"
  #   end

  #   it "should return an array of the csv" do
  #     writer = CsvWriter.new("unit/tmp/test.csv")
  #     results = writer.read_lines
  #     results.kind_of?(Array).should == true
  #     results.length.should == 2
  #     results.first.chomp.should == "test1, test2, test3"
  #     results[1].chomp.should == "test4, test5, test6"
  #   end
  # end
end