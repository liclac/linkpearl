class Character < ActiveRecord::Base
  include Parseable
  
  has_many :class_progresses, class_name: "CharacterClassProgress"
  has_many :classes, through: :class_progresses, class_name: "CharacterClass"
  
  def class_progresses_to_hash
    progress_hash = {}
    for progress in self.class_progresses do
      progress_hash[progress.character_class.name] = progress
    end
    progress_hash
  end
  
  def parse_doc(doc)
    name_link = doc.at_css('.player_name_txt h2 a')
    self.id = name_link['href'].split('/').last.to_i
    self.name = name_link.content
    
    progress_hash = class_progresses_to_hash
    for name_cell in doc.css('.class_list .ic_class_wh24_box') do
      next if name_cell.content.blank?
      
      level_cell = name_cell.next_element
      next if level_cell.content == '-'
      exp_cell = level_cell.next_element
      
      name = name_cell.content
      level = level_cell.content.to_i
      exp_at, exp_of = exp_cell.content.split('/')
      exp_at = exp_at.strip.to_i
      exp_of = exp_of.strip.to_i
      
      progress = progress_hash.fetch(name) { |k| CharacterClassProgress.for(k) }
      progress.level = level
      progress.exp_at = exp_at
      progress.exp_of = exp_of
      self.class_progresses << progress
    end
  end
end
