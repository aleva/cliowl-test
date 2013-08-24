# coding: utf-8

# This class contains cliowl test cases
#
# created: 2013-07-25
# author: Yuri David Santos

# JSON parsing
require 'json'

# HTTP requests
require './http-helper.rb'

# Local configurations
require './configuration.rb'

# Global constants
require './constants.rb'

# Build multipart data
require './multipart-data.rb'

class Tester

  # Test the fetch API method
  # 
  # @return [Boolean] true if the server response is as expected, false otherwise
  def test_fetch
    server = Configuration.SERVER
    addr = Configuration.CLIOWL_ADDRESS
    
    res = HttpHelper.get(server, "#{addr}/fetch")
    puts "\nTester#test_fetch:\n#{res}" if Configuration.VERBOSE
    res == Constants.FETCH_RESPONSE
  end
  
  # Test login with the correct parameters
  # 
  # @return [Boolean] true if the server returns a token with letters and numbers with the expected length, false 
  # otherwise
  def test_correct_login
    res = make_login Configuration.USER, Configuration.PASSWORD
    puts "\nTester#test_correct_login:\n#{res}" if Configuration.VERBOSE
    res and res.length == Constants.TOKEN_LENGTH and res =~ /^[0-9a-f]*$/
  end
  
  # Test login with a user that does not exist
  # 
  # @return [Boolean] true if the server returns a empty string, false otherwise
  def test_wrong_user_login
    res = make_login Configuration.WRONG_USER, Configuration.PASSWORD
    puts "\nTester#test_wrong_user_login:\n#{res}" if Configuration.VERBOSE
    res == Constants.FAILURE_MESSAGE
  end
  
  # Test login using a wrong password for an existing user
  # 
  # @return [Boolean] true if the server returns a empty string, false otherwise
  def test_wrong_password_login
    res = make_login Configuration.USER, Configuration.WRONG_PASSWORD
    puts "\nTester#test_wrong_password_login:\n#{res}" if Configuration.VERBOSE
    res == Constants.FAILURE_MESSAGE
  end
    
  # Test the creation of a new page
  # 
  # @return [Boolean] true if the page was successfully created, false otherwise
  def test_create_page
    file = Configuration.TEST_PAGE
    
    # This test depends on a succesfull login
    if test_correct_login
      token = make_login Configuration.USER, Configuration.PASSWORD
    else
      return false
    end
    
    page_key = 'page-test-' + random_string(Configuration.PAGE_KEY_RS_SIZE)
    res = post_page file, token, page_key, 'test-tag', 'This is a Test Page'
    
    # Remove the just created page
    remove_page page_key, token
    
    puts "\nTester#test_create_page:\n#{res}" if Configuration.VERBOSE
    res == Constants.SUCCESS_MESSAGE
  end
    
  # Test the deletion of a page
  # 
  # @return [Boolean] true if the page was successfully removed, false otherwise
  def test_remove_page
    file = Configuration.TEST_PAGE
    
    # This test depends on a succesfull login
    if test_correct_login
      token = make_login Configuration.USER, Configuration.PASSWORD
    else
      return false
    end
    
    page_key = 'page-test-' + random_string(Configuration.PAGE_KEY_RS_SIZE)
    
    # This test also depends on a succesfull page creation
    if test_create_page
      post_page file, token, page_key, 'test-tag', 'This is a Test Page'
    else
      return false
    end
    
    res = remove_page page_key, token
    puts "\nTester#test_remove_page:\n#{res}" if Configuration.VERBOSE 
    res == Constants.SUCCESS_MESSAGE
  end
  
  # Test updating a page
  # 
  # @return [Boolean] true if the page was successfully updated, false otherwise
  def test_update_page
    file = Configuration.TEST_PAGE
    file2 = Configuration.OTHER_TEST_PAGE
    
    # This test depends on a succesfull login
    if test_correct_login
      token = make_login Configuration.USER, Configuration.PASSWORD
    else
      return false
    end
    
    page_key = 'page-test-' + random_string(Configuration.PAGE_KEY_RS_SIZE)
    
    # This test also depends on a succesfull page creation
    if test_create_page
      post_page file, token, page_key, 'test-tag', 'This is a Test Page'
    else
      return false
    end
    
    res = post_page file2, token, page_key, 'test-tag-2', 'This is a Test Page 2'
    puts "\nTester#test_update_page:\n#{res}" if Configuration.VERBOSE 
    res == Constants.SUCCESS_MESSAGE
  end
  
  # Test listing pages
  # 
  # @return [Boolean] true if the pages was successfully listed, false otherwise
  def test_list_pages
    server = Configuration.SERVER
    addr = Configuration.CLIOWL_ADDRESS
    file = Configuration.TEST_PAGE
    file2 = Configuration.OTHER_TEST_PAGE
    user = Configuration.USER
    
    # This test depends on a succesfull login
    if test_correct_login
      token = make_login user, Configuration.PASSWORD
    else
      return false
    end
    
    page_key1 = 'page-test-' + random_string(Configuration.PAGE_KEY_RS_SIZE)
    page_key2 = 'page-test-' + random_string(Configuration.PAGE_KEY_RS_SIZE)
    page_key3 = 'page-test-' + random_string(Configuration.PAGE_KEY_RS_SIZE)

    pages = [ 
      { "key" => page_key1, "name" => 'This is a Test Page' },
      { "key" => page_key2, "name" => 'This is a Test Page' },
      { "key" => page_key3, "name" => 'This is a Test Page' } ]
    
    # This test also depends on succesfull page creation
    if test_create_page
      post_page file, token, pages[0]["key"], 'test-tag', pages[0]["name"]
      post_page file2, token, pages[1]["key"], 'test-tag', pages[1]["name"]
      post_page file, token, pages[2]["key"], 'test-tag', pages[2]["name"]
    else
      return false
    end
    
    res = HttpHelper.get(server, "#{addr}/list/#{user}")
    
    begin
      # Parse JSON return
      page_list = JSON.parse res
    rescue
      return false
    end
    
    # Checks if all the page keys matches
    keys_match = true
    
    pages.each do |p|
      page_key_match = false
      
      page_list.each do |p2|
        page_key_match = true if p["key"] == p2["key"]
      end
      
      remove_page p["key"], token      
      keys_match = false if not page_key_match
    end
    
    puts "\nTester#test_list_pages:\n#{res}" if Configuration.VERBOSE
    page_list.size == pages.size and keys_match    
  end
  
  def test_get_page
    server = Configuration.SERVER
    addr = Configuration.CLIOWL_ADDRESS
    file = Configuration.TEST_PAGE
    user = Configuration.USER
    
    file_content = File.read(file)
    
    # This test depends on a succesfull login
    if test_correct_login
      token = make_login user, Configuration.PASSWORD
    else
      return false
    end
    
    key = 'page-test-' + random_string(Configuration.PAGE_KEY_RS_SIZE)
    
    if test_create_page
      post_page file, token, key, 'test-tag', 'This is a Test Page'
    else
      return false
    end
    
    res = HttpHelper.get(server, "#{addr}/page/#{user}/#{key}")
    puts "\nTester#test_get_page:\n#{res}" if Configuration.VERBOSE    
    res == file_content
  end
  
  # Try to make login
  # 
  # @param [String] user - user name that will be used to login
  # @param [String] password - password that will be used to login
  # @return [String] the server response to the login attempt
  def make_login user, password
    server = Configuration.SERVER
    addr = Configuration.CLIOWL_ADDRESS
    
    HttpHelper.post "http://#{server}#{addr}/login", { 'user' => user, 'password' => password }
  end
  
  # Posts a page (create or delete)
  # 
  # @param [String] file - name of the file with the page contents
  # @param [String] token - authentication token
  # @param [String] key - key that identifies the new page
  # @param [String] tags - tags of this page, comma separated
  # @param [String] title - title for the new page
  # @return [Boolean] true if the page was successfully created, false otherwise
  def post_page file, token, key, tags, title
    server = Configuration.SERVER
    addr = Configuration.CLIOWL_ADDRESS

    # Builds the multipart data
    data = MultipartData.new
    data.add_field 'token', token
    data.add_field 'key', key
    data.add_field 'tags', tags
    data.add_field 'title', title
    
    file_content = File.read(file)
    data.add_file 'file', file, 'text/plain', file_content
    
    HttpHelper.post_multipart "http://#{server}#{addr}/page", data
  end
  
  # Removes a page identified by a key
  #
  # @param [String] key - key that identifies the page that will be removed
  # @param [String] token - authentication token
  def remove_page key, token
    server = Configuration.SERVER
    addr = Configuration.CLIOWL_ADDRESS
    HttpHelper.get(server, "#{addr}/remove/#{key}/#{token}")
  end

  # Creates a random string 
  #
  # @param [int] size - Size of the string
  def random_string size 
    (0..size).map { ('a'..'z').to_a[rand(26)] }.join
  end
end
