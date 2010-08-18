# encoding: utf-8
require 'fileutils'
require "yaml"

module YmlTranslator
  class LocaleFile
    
    def initialize(filepath, output)
      @filepath = filepath
      @output = output
      @document = YAML::load(File.open(@filepath, 'r'))
      @current_locale = @document.keys.first.to_s
    end
    
    def to_locale(locales = [])
      create_directories
      files = []
      
      [locales].flatten.each do |locale|
        files << generate(locale)
      end
      
      files
    end
    
    protected
      
      def create_directories
        FileUtils.mkdir_p(@output) unless FileTest.exist?(@output)
      end
      
      def create_file(locale)
        filename = File.basename(@filepath)
        filepath = File.join(@output, "#{locale}.#{filename}")
        
        file = File.new(filepath, "w")
        file.puts("# Brainberry YmlTranslator 2010")
        file.puts("# Translated from '#{@current_locale}' to '#{locale}' locale")
        file
      end
      
      def generate(locale)
        file = create_file(locale)
        
        IO.readlines(@filepath).each do |line|
          if line.to_s.gsub(':', '').strip == @current_locale
            file.puts("#{locale}:")
          elsif line.include?(':')
            # TODO: translate value
            items = line.split(':')
            value = items.last.strip
            file.puts([ items.first, value ].join(': '))
          else
            file.puts(line)
          end
        end
        
        file.close
        file.path
      end
  end
end
