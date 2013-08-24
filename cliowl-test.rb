#!/usr/bin/ruby
# coding: utf-8

# cliowl test suite
#
# created: 2013-07-25
# author: Yuri David Santos

require './tester.rb'

class Main

  def initialize      
    @fail = 0
    @pass = 0
    @tester = Tester.new
    
    puts "\n"
    puts "cliowl API Test Suite"
    puts "------ --- ---- -----"
    puts "\n"

    options = ['-h', '--help', '-v']

    if ARGV.size > 0
      if ARGV.include? '-v'
        Configuration.VERBOSE = true
      end
      
      if not options.include? ARGV[0]        
        execute_test ARGV[0]
        exit
      end
      
      if ARGV.include? '-h' or ARGV.include? '--help'
        puts 'Help Page'
        puts ''
        puts 'usage: ./cliowl-test.rb'
        puts ''
        puts 'command line options:'
        puts "\t-h, --help\tDisplays this help message"
        puts "\t-v\tTurn verbose mode on, displaying API responses"
        exit
      end
    end

    execute_all_tests
    
    puts "\nTotal of #{(@fail + @pass)} tests executed, #{@pass} passed, #{@fail} failed."
  end

  def execute_all_tests
    # for each method of the test class, calls the method and tells if it passed
    @tester.class.instance_methods(false).each do |method|
      m = method.to_s
      execute_test m[5..-1] if m.start_with? 'test_'
    end
  end

  # Executes one test
  #
  # @param [String] test_key - name of the test method without the "test_"
  def execute_test test_key
    method_name = 'test_' + test_key
    test_name = test_key.split('_').map(&:capitalize).join(' ')
  
    if @tester.respond_to? method_name
      # Terminal ANSI color codes (PASS in green, FAIL in red)
      success_color = "\033[1;32m"
      failure_color = "\033[1;31m"
      normal_color = "\033[0m"
    
      if @tester.send method_name
        test_result = "#{success_color}PASS#{normal_color}"
        @pass += 1
      else
        test_result = "#{failure_color}FAIL#{normal_color}"
        @fail += 1
      end
    
      puts test_result + "\t" + test_name
    else
      puts "Unknown method '#{method_name}'"
    end
  end
  
end

Main.new
