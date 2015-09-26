class FreeCompany
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  has_many :characters
end
