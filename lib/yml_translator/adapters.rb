# encoding: utf-8

Dir["#{File.dirname(__FILE__)}/adapters/*.rb"].sort.each do |path|
  require File.join(File.dirname(__FILE__), "adapters", File.basename(path, '.rb'))
end

module YmlTranslator
  module Adapters
    
    def self.load_adapter(provider_name)
      case provider_name.to_s.downcase
        when 'google'   then GoogleAdapter
        when 'metaua'   then MetauaAdapter
        when 'onlineua' then OnlineuaAdapter
      end
    end
    
  end
end
