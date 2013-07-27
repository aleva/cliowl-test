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
    expected = Constants.fetch_response
    addr = Configuration.cliowl_address

    Net::HTTP.get(server, "#{addr}/fetch") == expected
  end
  
  def test_login_ok
    server = Configuration.server
    addr = Configuration.cliowl_address
    user = Configuration.user
    pw = Configuration.password
    token_length = Constants.token_length
    
    uri = URI("http://#{server}#{addr}/login")
    res = Net::HTTP.post_form(uri, 'txtusuario' => 'yuri', 'txtsenha' => 'abc')
    res.body.length == token_length and res.body =~ /^[0-9a-zA-Z]*$/
  end
end
