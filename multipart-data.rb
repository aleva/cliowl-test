# coding: utf-8

# created: 2013-08-06
# author: Yuri David Santos

# This class provides support to build multipart data to use for HTTP posts
# with files and other data
class MultipartData

  # Gets or sets the boundary used to separate multipart data fields
  attr_accessor :boundary

  def initialize
    @params = []
    @boundary = '8237408635084605133298472980147256701603264978123964023956'
  end
    
  # Add a field with its value to the multipart data
  # 
  # @param [String] name - name of the field
  # @param [String] value - value of the field
  def add_field name, value
    @params << "Content-Disposition: form-data; name=\"#{name}\"\n" + 
    "\n" + 
    "#{value}\n"
  end
    
  # Add a file to the multipart data
  # 
  # @param [String] name - name of the field
  # @param [String] file - name of the file that will be posted in this field
  # @param [String] mime - mime type of the file
  # @param [String] content - file content
  def add_file name, file, mime, content
    @params << 
      "Content-Disposition: form-data; name=\"#{name}\"; filename=\"#{file}\"\n" +
      "Content-Transfer-Encoding: binary\n" +
      "Content-Type: #{mime}\n" + 
      "\n" + 
      "#{content}\n"
  end
  
  # Build and return the complete multipart data
  # @return multipart data
  def build
    @params.map { |p| '--' + @boundary + "\n" + p }.join('') + "--" + @boundary + "--\n"
  end

end
