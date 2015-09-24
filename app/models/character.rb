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
  
  # General information
  field :name, type: String
  belongs_to :title
  
  # Primary attributes
  field :str, type: Integer
  field :dex, type: Integer
  field :vit, type: Integer
  field :int, type: Integer
  field :mnd, type: Integer
  field :pie, type: Integer
  
  # Secondary attributes
  field :acc, type: Integer
  field :crt, type: Integer
  field :det, type: Integer
  field :par, type: Integer
  field :sks, type: Integer
  field :sps, type: Integer
  
  # Classes, levels and exp
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
  
  # Indices
  index :name => 1
  index "levels.cls" => 1
  
  # Update data from an HTML document
  def parse_doc(doc)
    # General information
    name_link = doc.at_css('.player_name_txt h2 a')
    self.id = name_link['href'].split('/').last.to_i
    self.name = name_link.content
    
    # Title
    title_s = doc.at_css('.chara_title').try(:content).try(:strip)
    self.title = title_s ? Title.find_or_create_by(name: title_s) : nil
    
    # Classes, levels and exp
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
    
    # Primary stats
    stat_cells = doc.css('.param_list_attributes li span')
    [:str, :dex, :vit, :int, :mnd, :pie].each_with_index do |stat, i|
      cell = stat_cells[i]
      self[stat] = cell.content.to_i
    end
    
    # Secondary stats
    attrs = {
      "Accuracy" => :acc, "Critical Hit Rate" => :crt,
      "Determination" => :det, "Parry" => :par,
      "Skill Speed" => :sks, "Spell Speed" => :sps,
    }
    doc.css('.param_list li').each do |cell|
      name = cell.first_element_child.content
      next unless attrs.has_key? name
      
      value = cell.last_element_child.content.to_i
      sym = attrs[name]
      self[sym] = value
    end
  end
end
