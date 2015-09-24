module Parseable
  extend ActiveSupport::Concern
  
  included do
    def doc_from_html(html)
      Nokogiri::HTML(html) do |config|
        config.noent.nonet
      end
    end
    
    def parse_html(html)
      parse_doc doc_from_html(html)
    end
    
    def self.from_html(html)
      cls = Object.const_get name
      inst = cls.new
      inst.parse_html html
      inst
    end
  end
end
