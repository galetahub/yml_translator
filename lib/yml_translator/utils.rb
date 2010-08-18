# encoding: utf-8
require 'fileutils'

module YmlTranslator
  module Utils
    class << self
    
      def each_files(file_or_folder = nil, &block)
        path = file_or_folder.nil? ? File.dirname(__FILE__) : file_or_folder
        
        if FileTest.directory?(path)
          Dir[ File.join(path, "*.yml")].sort.each do |path|
            yield path
          end     
        elsif FileTest.exist?(path)
          yield path
        end
      end
    
    end
    
  end
end
