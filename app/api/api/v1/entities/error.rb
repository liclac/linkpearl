module API
  module V1
    module Entities
      class Error < Grape::Entity
        expose :error, documentation: {
          type: String, required: true, defaultValue: "Can't let you do that",
          desc: "A short error message"
        }
        
        def self.entity_name() "Error" end
      end
    end
  end
end
