# coding: utf-8

# This class contains cliowl test cases
#
# created: 2013-07-25
# author: Yuri David Santos

# Lib for http requests
require 'net/http'

# Local configurations
require './configuration.rb'

# Global constants
require './constants.rb'

class Tester

  # Test the fetch API method
  # 
  # @return [Boolean] true if the server response is as expected, false otherwise
  def test_fetch
    server = Configuration.server
    addr = Configuration.cliowl_address
    Net::HTTP.get(server, "#{addr}/fetch") == Constants.fetch_response
  end
  
  # Test login with the correct parameters
  # 
  # @return [Boolean] true if the server returns a token with letters and numbers with the expected length, false 
  # otherwise
  def test_correct_login
    res = make_login Configuration.user, Configuration.password
    res.length == Constants.token_length and res =~ /^[0-9a-zA-Z]*$/
  end
  
  # Test login with a user that does not exist
  # 
  # @return [Boolean] true if the server returns a empty string, false otherwise
  def test_wrong_user_login
    res = make_login Configuration.wrong_user, Configuration.password
    res == Constants.failure_message
  end
  
  # Test login using a wrong password for an existing user
  # 
  # @return [Boolean] true if the server returns a empty string, false otherwise
  def test_wrong_password_login
    res = make_login Configuration.user, Configuration.wrong_password
    res == Constants.failure_message
  end
  
  # Try to make login
  # 
  # @param [String] user - user name that will be used to login
  # @param [String] password - password that will be used to login
  # @return [String] the server response to the login attempt
  def make_login user, password
    server = Configuration.server
    addr = Configuration.cliowl_address
        
    uri = URI("http://#{server}#{addr}/login")
    res = Net::HTTP.post_form(uri, 'user' => user, 'password' => password)
    res.body
  end
end
