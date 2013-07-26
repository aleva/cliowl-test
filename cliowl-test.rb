#!/usr/bin/ruby
# coding: utf-8

# cliowl test suite
#
# created: 2013-07-25
# author: Yuri David Santos

require './tester.rb'

tester = Tester.new

# for each method of the test class, calls the method and tells if it passed
tester.class.instance_methods(false).each do |method|
  m = method.to_s

  if m.start_with? 'test_'
    test_name = m[5..-1].split('_').map(&:capitalize).join(' ')
    test_result = ((tester.send method) ? 'passed' : 'failed').to_s
    puts test_name + ': ' + test_result
  end
end
