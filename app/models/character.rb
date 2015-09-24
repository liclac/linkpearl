class Character
  class Level
    include Mongoid::Document
    include Mongoid::Timestamps
    
    field :cls, type: String
    field :level, type: Integer
    field :exp, type: Integer
    field :need, type: Integer
    
    embedded_in :character
  end
  
  include Mongoid::Document
  include Mongoid::Timestamps
  include Parseable
  
  field :name, type: String
  field :stats, type: Hash
  
  embeds_many :levels, class_name: "Character::Level" do
    def for(cls)
      lvl = @target.detect {|v| v.cls == cls}
      if not lvl
        lvl = Character::Level.new
        lvl.cls = cls
        push lvl
      end
      lvl
    end
  end
  
  index :name => 1
  index({ "levels.cls" => 1 }, { unique: true })
  
  def parse_doc(doc)
    name_link = doc.at_css('.player_name_txt h2 a')
    self.id = name_link['href'].split('/').last.to_i
    self.name = name_link.content
    
    for cls_cell in doc.css('.class_list .ic_class_wh24_box') do
      next if cls_cell.content.blank?
      
      level_cell = cls_cell.next_element
      next if level_cell.content == '-'
      exp_cell = level_cell.next_element
      
      cls = cls_cell.content
      level = level_cell.content.to_i
      exp, need = exp_cell.content.split('/')
      exp = exp.strip.to_i
      need = need.strip.to_i
      
      lvl = levels.for cls
      lvl.level = level
      lvl.exp = exp
      lvl.need = need
    end
  end
end
