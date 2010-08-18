# encoding: utf-8
require 'optparse'

module YmlTranslator
  class Config
    # The options specified on the command line will be collected in *options*.
    # We set default values here.
    def self.parse(args)
      options = Hash.new
      directory = File.join(Dir.pwd, 'config', 'locales')
      
      options[:source] = directory
      options[:output] = directory
      options[:locales] = 'uk'
      options[:encoding] = "utf8"
      options[:provider] = YmlTranslator.providers.first
      
      opts = OptionParser.new do |opts|
        opts.banner = "Usage: yml_translator [options]"
        
        opts.separator ""
        opts.separator "Specific options:"

        # Source argument.
        opts.on("-s", "--source [PATH]",
                "Path to I18n locale file or folder with locales files which your want translate") do |path|
          options[:source] = path
        end

        # Output folder argument
        opts.on("-o", "--output [PATH]",
                "Path where store output translated locales files") do |path|
          options[:output] = path
        end
        
        # Locales argument
        opts.on("-l", "--locales [LOCALES]", Array,
                "List of locales which will be translated to, for example: ru,uk,en") do |list|
          options[:locales] = list
        end
        
        # Provider argument
        opts.on("-p", "--provider [PROVIDER]", YmlTranslator.providers,
                "Service to translate texts. Allowed: google/metaua/onlineua") do |name|
          options[:provider] = name
        end

        opts.separator ""
        opts.separator "Common options:"

        # No argument, shows at tail.  This will print an options summary.
        # Try it and see!
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end

        # Another typical switch to print the version.
        opts.on_tail("--version", "Show version") do
          puts YmlTranslator::Version.dup
          exit
        end
      end
      
      opts.parse!(args)
      options
    end    
  end
end
