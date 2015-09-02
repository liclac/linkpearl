class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters, :id => false do |t|
      t.integer :id, :limit => 8
      t.string :name
      t.timestamps null: false
    end
  end
end
