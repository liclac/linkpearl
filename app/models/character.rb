class Character < ActiveRecord::Base
  include Parseable
  
  def parse_doc(doc)
    name_link = doc.at_css('.player_name_txt h2 a')
    self.id = name_link['href'].split('/').last.to_i
    self.name = name_link.content
  end
end
