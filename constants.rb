# coding: utf-8

# created: 2013-07-25
# author: Yuri David Santos

# Global constants
class Constants

  # Expected response to a fetch request
  @@fetch_response = 'CLIOWL SERVER API'  
  def self.fetch_response
    @@fetch_response
  end

  # Session token length
  @@token_length = 32 
  def self.token_length
    @@token_length
  end

  # Generic success message
  @@success_message = '0' 
  def self.success_message
    @@success_message
  end

  # Generic failure message
  @@failure_message = '' 
  def self.failure_message
    @@failure_message
  end
  
end
