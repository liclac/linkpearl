class World
  include Mongoid::Document
  
  field :name, type: String
  has_many :characters
end
