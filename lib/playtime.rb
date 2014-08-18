class Playtime
  def self.thread_test
    arr = []
    a, b, c = 1, 2, 3
    2.times do |i|
      Thread.new(a,b,c) { |d,e,f| arr << d << e << f }.join
    end
    arr
  end

  # Use splatter in the block given
  def self.block_method(*splatter, &test)
    test.call(splatter) rescue raise Playtime::ErrorCallingBlock
  end

  class ErrorCallingBlock < StandardError
  end

  # alias old_backquote `
  # def `(cmd)
  #   result = old_backquote(cmd)
  #   if $? != 0
  #     puts "*** Command #{cmd} failed: status = #{$?.exitstatus}"
  #   end
  #   result
  # end
  # print `ls -l /etc/passwd`
  # print `ls -l /etc/wibble`
  # produces:
  # -rw-r--r-- 1 root wheel 5148 Oct 18 2011 /etc/passwd
  # ls: /etc/wibble: No such file or directory
  # *** Command ls -l /etc/wibble failed: status = 1

end


# class Test
#   def val=(val)
#     @val = val
#     return 99
#   end
# end

# t = Test.new
# result = (t.val = 2)
# result # => 2 in ruby 1.9, 99 in ruby 1.8

# Splat assignments are greedy:
# a, *b = 1, 2, 3             # a=1, b=[2, 3]
# a, *b = 1                   # a=1, b=[]
# *a, b = 1, 2, 3, 4          # a=[1, 2, 3], b=4
# c, *d, e = 1, 2, 3, 4       # c=1, d=[2, 3], e=4
# f, *g, h, i, j = 1, 2, 3, 4 # f=1, g=[], h=2, i=3, j=4

# Nested assignments
# a, (b, c), d = 1,2,3,4 # a=1, b=2, c=nil, d=3
# a, (b, c), d = [1,2,3,4] # a=1, b=2, c=nil, d=3
# a, (b, c), d = 1,[2,3],4 # a=1, b=2, c=3, d=4
# a, (b, c), d = 1,[2,3,4],5 # a=1, b=2, c=3, d=5
# a, (b,*c), d = 1,[2,3,4],5 # a=1, b=2, c=[3, 4], d=5

# Any value that is not nil or the constant false is true — "cat", 99, 0, and :a_song are all considered true
 
# If defined? argument is yield, returns the string “yield” if a code block is associated with the current context.
# defined? 1 # => "expression"
# defined? dummy # => nil
# defined? printf # => 'method'
# defined? String # => 'constant'
# defined? $_ # => 'global-variable'
# defined? Math::PI # => 'constant'
# defined? a = 1 # => 'assignment'
# defined? 42.abs  # => 'method'
# defined? nil # => 'nil'

# require 'open-uri'
# page = "podcasts"
# file_name = "#{page}.html"
# web_page = open("http://pragprog.com/#{page}")
# output = File.open(file_name, "w")
# begin
#   while line = web_page.gets
#     output.puts line
#   end
#   output.close
# rescue Exception
#   STDERR.puts "Failed to download #{page}: #{$!}"
#   output.close
#   File.delete(file_name)
#   raise
# end

# After closing and deleting the file, we call raise with no parameters, which reraises the
# exception in $!. This is a useful technique, because it allows you to write code that filters
# exceptions, passing on those you can’t handle to higher levels. It’s almost like implementing
# an inheritance hierarchy for error processing.

# require 'open-uri'
# require 'hpricot'
# page = Hpricot(open('http://pragprog.com'))
# puts "Page title is " + page.at(:title).inner_html
# # Output the first paragraph in the div with an id="copyright"
# puts page.at('div#copyright p')
# # Output the second hyperlink in the site-links div
# puts "\nSecond hyperlink is"
# puts page.at('div#site-links a:nth(2)')

# count = 0
# threads = 10.times.map do |i|
#   Thread.new do
#     sleep(rand(0.1))
#     Thread.current[:mycount] = count
#     count += 1
#   end
# end
# threads.each {|t| t.join; print t[:mycount], ", " }
# puts "count = #{count}"
# produces:
# 2, 0, 8, 6, 5, 4, 1, 9, 3, 7, count = 10

# sum = 0
# mutex = Mutex.new
# threads = 10.times.map do
#   Thread.new do
#     100_000.times do
#       # Or: mutex.synchronize { ... }
#       mutex.lock
#       one at a time, please
#       new_value = sum + 1
#       print "#{new_value}\n" if new_value % 250_000 == 0
#       sum = new_value
#       mutex.unlock
#     end
#   end
# end
# threads.each(&:join)
# puts "sum = #{sum}"

# # Show when a process will finish
# trap("CLD") do
#   pid = Process.wait
#   puts "Child pid #{pid}: terminated"
# end
# fork { exec("sort testfile > output.txt") }
# # Do other stuff...
# produces:
# Child pid 89492: terminated

# If you associate a block with fork, the code in the block will be run in a Ruby subprocess, and
# the parent will continue after the block:
# fork do
#   puts "In child, pid = #$$"
#   exit 99
# end
# pid = Process.wait
# puts "Child terminated, pid = #{pid}, status = #{$?.exitstatus}"
# produces:
# In child, pid = 89499
# Child terminated, pid = 89499, status = 99
# $? is a global variable that contains information on the termination of a subprocess


# ruby -r debug ‹ debug-options › ‹ programfile › ‹ program-arguments ›
# 200 (213) - list of debug options

# irb is essentially a Ruby “shell” similar in concept to an operating system shell (complete with job control). It provides an environment where you can “play around” with the language in real time.
# irb ‹ irb-options › ‹ ruby_script › ‹ program-arguments ›





# def one(arg)
#   if block_given?
#     "block given to 'one' returns #{yield}"
#   else
#     arg
#   end
# end
# def two
#   if block_given?
#     "block given to 'two' returns #{yield}"
#   end
# end
# result1 = one two {
#   "three"
# }
# result2 = one two do
#   "three"
# end
# puts "With braces, result = #{result1}"
# puts "With do/end, result = #{result2}"
# produces:
# With braces, result = block given to 'two' returns three
# With do/end, result = block given to 'one' returns three


#   $ gem environment gemdir
# /usr/local/lib/ruby/gems/1.9.3

# $ gem server
# Server started at http://[::ffff:0.0.0.0]:8808
# Server started at http://0.0.0.0:8808









