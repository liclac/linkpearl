class Title
  include Mongoid::Document
  
  field :name, type: String
  has_many :characters
end
