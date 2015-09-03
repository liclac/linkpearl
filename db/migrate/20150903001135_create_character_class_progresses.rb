class CreateCharacterClassProgresses < ActiveRecord::Migration
  def change
    create_table :character_class_progresses do |t|
      t.belongs_to :character, index: true, foreign_key: true
      t.belongs_to :character_class, index: true, foreign_key: true
      t.integer :level
      t.integer :exp_at
      t.integer :exp_of

      t.timestamps null: false
    end
  end
end
