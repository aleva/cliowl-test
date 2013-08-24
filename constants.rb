# coding: utf-8

# created: 2013-07-25
# author: Yuri David Santos

# Global constants
class Constants

  # Expected response to a fetch request
  @@FETCH_RESPONSE = 'CLIOWL SERVER API'  
  def self.FETCH_RESPONSE
    @@FETCH_RESPONSE
  end

  # Session token length
  @@TOKEN_LENGTH = 32 
  def self.TOKEN_LENGTH
    @@TOKEN_LENGTH
  end

  # Generic success message
  @@SUCCESS_MESSAGE = '0' 
  def self.SUCCESS_MESSAGE
    @@SUCCESS_MESSAGE
  end

  # Generic failure message
  @@FAILURE_MESSAGE = '' 
  def self.FAILURE_MESSAGE
    @@FAILURE_MESSAGE
  end
  
end
