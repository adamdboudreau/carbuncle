class CsvWriter
	attr_reader :filename
	
	def initialize(filename)
		@filename = filename || ""
	end

	def append_text(text)
		if File.exist?(File.expand_path(@filename))
			open(File.expand_path(@filename), 'a') do |f|
			  f.puts text
			end

			# existingFile = File.open(File.expand_path(@filename), "a")
			# begin
			# 	existingFile << text || ""
			# ensure
			# 	existingFile.close
			# end

		else
			open(File.expand_path(@filename), "w") do |f|
				f.puts text
			end

			# begin
			# 	newFile << text || ""
			# ensure
			# 	newFile.close
			# end
		end
	end

	def append_lines(lines)	
		raise "Expected lines to be an array" unless lines.kind_of?(Array)

		if File.exist?(File.expand_path(@filename))
			open(File.expand_path(@filename), 'a') do |f|
				lines.each do |line|
					f.puts line
				end
			end

		else
			open(File.expand_path(@filename), "w") do |f|
				lines.each do |line|
					f.puts line
				end
			end

		end

		# newFile = File.open(File.expand_path(@filename), "w")
		# begin
		# 	if lines.kind_of?(Array)
		# 		lines.each do |line|
		# 			newFile << line
		# 			newFile << "\n"
		# 		end
		# 	else
		# 		raise "Expected lines to be an array"
		# 	end
		# ensure
		# 	newFile.close
		# end
	end
	# def exist?
	# 	File.exist?(File.expand_path(@filename))
	# end

	# def read_lines
	# 	IO.readlines(File.expand_path(@filename))
	# end
end