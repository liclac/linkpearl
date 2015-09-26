class World
  include Mongoid::Document
  
  field :name, type: String
  index({name: 1}, unique: true)
  has_many :characters
end
