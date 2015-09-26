module API
  module V1
    module Entities
      class World < Grape::Entity
        expose :name, documentation: {
          type: String, required: true, defaultValue: "Aegis",
          desc: "Name of the world"
        }
        
        expose :population, documentation: {
          type: Integer, required: true, defaultValue: 9001,
          desc: "Total known population"
        }
        
        def population
          object.characters.count
        end
      end
    end
  end
end
