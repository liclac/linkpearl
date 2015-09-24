class CharacterClassProgress < ActiveRecord::Base
  belongs_to :character, touch: true
  belongs_to :character_class
  
  def self.for(class_name)
    progress = CharacterClassProgress.new
    progress.character_class = CharacterClass.find_or_initialize_by(name: class_name)
    progress
  end
end
