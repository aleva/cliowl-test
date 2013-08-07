# coding: utf-8

# created: 2013-08-06
# author: Yuri David Santos

# Lib for http requests
require 'net/http'

# All HTTP requests will be done here
class HttpHelper
  
  # Makes a get HTTP request
  #
  # @param [String] server - host name
  # @param [String] address - URL
  # @return [String] server response
  def self.get server, address
    Net::HTTP.get(server, address)
  end
  
  # Makes a get HTTP request
  #
  # @param [String] url - URL to post to
  # @param [String] data - hash with the data fields
  # @return [String] server response
  def self.post url, data
    uri = URI(url)
    res = Net::HTTP.post_form(uri, data)
    res.body
  end
  
  # Make a post with multipart data
  # 
  # @param [String] url - URL to post to
  # @param [MultipartData] data - data that will be posted
  # @return [String] the server response to the post
  def self.post_multipart url, data
    url = URI.parse(url)
    req = Net::HTTP::Post.new(url.path)
    req.content_length = data.build.size
    req.content_type = 'multipart/form-data; boundary=' + data.boundary
    req.body = data.build
    res = Net::HTTP.new(url.host, url.port).start do |http| http.request(req) end    
    res.body
  end
  
end
