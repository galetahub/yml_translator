# encoding: utf-8

Dir["#{File.dirname(__FILE__)}/yml_translator/*.rb"].sort.each do |path|
  require File.join(File.dirname(__FILE__), "yml_translator", File.basename(path, '.rb'))
end

module YmlTranslator
  class << self
    def run(options = {})
      adapter = Adapters.load_adapter(options[:provider])
      
      Utils.each_files(options[:source]) do |filepath|
        file = LocaleFile.new(filepath, options[:output])
        files = file.to_locale(options[:locales])
        
        puts "Created files:"
        puts files
      end 
    end
    
    # Current allowed services to translate texts
    def providers
      ["google", "metaua", "onlineua"]
    end
  
  end
    
end
