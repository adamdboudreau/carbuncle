class CsvReader
	attr_reader :filename
	
	def initialize(filename)
		@filename = filename || ""
	end

	def exist?
		File.exist?(File.expand_path(@filename))
	end

	def read_lines
		IO.readlines(File.expand_path(@filename))
	end
end