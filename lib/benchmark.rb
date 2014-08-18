# define the benchmark module so executing rspec will load this file properly (include Benchmark runs into another problem)
module Benchmark
end

# require 'benchmark'
# include Benchmark

# LOOP_COUNT = 1_000_000
# bmbm(12) do |test|
#   test.report("inline:") do
#     LOOP_COUNT.times do |x|
#       # nothing
#     end
#   end

#   test.report("method:") do
#     def method
#     # nothing
#     end

#     LOOP_COUNT.times do |x|
#       method
#     end
#   end
# end


# ruby benchmark.rb 
# Rehearsal ------------------------------------------------
# inline:        0.060000   0.000000   0.060000 (  0.055038)
# method:        0.080000   0.000000   0.080000 (  0.078349)
# --------------------------------------- total: 0.140000sec

#                    user     system      total        real
# inline:        0.050000   0.000000   0.050000 (  0.048637)
# method:        0.080000   0.000000   0.080000 (  0.080522)
