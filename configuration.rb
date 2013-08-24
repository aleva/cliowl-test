# coding: utf-8

# created: 2013-07-25
# author: Yuri David Santos

# Local configurations that must be changed to test your cliowl implementation
class Configuration
  
  # Boundary for multipart data http posts
  @@MULTIPART_BOUNDARY = '8237408635084605133298472980147256701603264978123964023956'
  def self.MULTIPART_BOUNDARY
    @@MULTIPART_BOUNDARY
  end  

  # True if the program is on verbose mode
  @@VERBOSE = false
  def self.VERBOSE
    @@VERBOSE
  end  
  def self.VERBOSE= value
    @@VERBOSE = value
  end

  # Size of the random string that is appended to test page keys  
  @@PAGE_KEY_RS_SIZE = 50
  def self.PAGE_KEY_RS_SIZE
    @@PAGE_KEY_RS_SIZE
  end  

  # Address of the cliowl server that contains the implementation being tested (without "http://")
  @@SERVER = 'localhost'  
  def self.SERVER
    @@SERVER
  end
  
  # Path to the cliowl instance from the server web root
  @@CLIOWL_ADDRESS = '/cliowl'  
  def self.CLIOWL_ADDRESS
    @@CLIOWL_ADDRESS
  end
  
  # User that exists within the cliowl server
  @@USER = 'root'  
  def self.USER
    @@USER
  end
  
  # Password of a user that exists within the cliowl server
  @@PASSWORD = 'abcde12345'  
  def self.PASSWORD
    @@PASSWORD
  end
  
  # User that does not exist within the cliowl server
  @@WRONG_USER = 'wrong_user'  
  def self.WRONG_USER
    @@WRONG_USER
  end
  
  # Wrong password for the user @@user
  @@WRONG_PASSWORD = 'wrong_password'  
  def self.WRONG_PASSWORD
    @@WRONG_PASSWORD
  end
  
  # A test file with content for a page (in markdown format) 
  @@TEST_PAGE = 'data/test.md'  
  def self.TEST_PAGE
    @@TEST_PAGE
  end
  
  # A test file with content for a page (in markdown format) different from the previous one
  @@OTHER_TEST_PAGE = 'data/test2.md'  
  def self.OTHER_TEST_PAGE
    @@OTHER_TEST_PAGE
  end
  
end
