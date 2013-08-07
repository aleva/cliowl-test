# coding: utf-8

# created: 2013-07-25
# author: Yuri David Santos

# Local configurations that must be changed to test your cliowl implementation
class Configuration

  # Address of the cliowl server that contains the implementation being tested (without "http://")
  @@server = 'localhost'  
  def self.server
    @@server
  end
  
  # Path to the cliowl instance from the server web root
  @@cliowl_address = '/cliowl'  
  def self.cliowl_address
    @@cliowl_address
  end
  
  # User that exists within the cliowl server
  @@user = 'root'  
  def self.user
    @@user
  end
  
  # Password of a user that exists within the cliowl server
  @@password = 'abcde12345'  
  def self.password
    @@password
  end
  
  # User that does not exist within the cliowl server
  @@wrong_user = 'wrong_user'  
  def self.wrong_user
    @@wrong_user
  end
  
  # Wrong password for the user @@user
  @@wrong_password = 'wrong_password'  
  def self.wrong_password
    @@wrong_password
  end
  
  # A test file with content for a page (in markdown format) 
  @@test_page = 'data/test.md'  
  def self.test_page
    @@test_page
  end
  
  # A test file with content for a page (in markdown format) different from the previous one
  @@other_test_page = 'data/test2.md'  
  def self.other_test_page
    @@other_test_page
  end
  
end
