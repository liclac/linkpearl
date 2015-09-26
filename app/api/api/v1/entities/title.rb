module API
  module V1
    module Entities
      class Title < Grape::Entity
        expose :name, documentation: {
          type: String, required: true, defaultValue: "The Heart of the Party",
          desc: "Name of the title"
        }
        
        expose :bearers, documentation: {
          type: Integer, required: true, defaultValue: 9001,
          desc: "Total known bearers"
        }
        
        def bearers
          object.characters.count
        end
      end
    end
  end
end
