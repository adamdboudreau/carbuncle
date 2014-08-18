# Profiling has a serious overhead, but the assumption is that it
# applies across the board, and therefore the relative numbers are still meaningful.

require 'profile'

<?location code/trouble/profileeg.rb@1 ?>

count = 0
words = File.open("/usr/share/dict/words")
while word = words.gets
  word = word.chomp!
  if word.length == 12
    count += 1
  end
end
puts "#{count} twelve-character words"