#!/usr/bin/ruby
# coding: utf-8

# cliowl test suite
#
# created: 2013-07-25
# author: Yuri David Santos

require './tester.rb'

puts "\n"
puts "cliowl API Test Suite"
puts "------ --- ---- -----"
puts "\n"

tester = Tester.new

fail = 0
pass = 0

# for each method of the test class, calls the method and tells if it passed
tester.class.instance_methods(false).each do |method|
  m = method.to_s

  if m.start_with? 'test_'
    test_name = m[5..-1].split('_').map(&:capitalize).join(' ')
    
    if tester.send method
      test_result = 'PASS'
      pass += 1
    else
      test_result = 'FAIL'
      fail += 1
    end
    
    puts test_result + "\t" + test_name
  end
end

puts "\nTotal of #{(fail + pass)} tests executed, #{pass} passed, #{fail} failed."
