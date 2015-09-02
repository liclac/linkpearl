class Character < ActiveRecord::Base
  include Parseable
  
  def parse_doc(doc)
    self.name = doc.at_css('.player_name_txt h2 a').content
  end
end
