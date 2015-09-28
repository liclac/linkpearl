module API
  module V1
    module Entities
      class GrandCompany < Grape::Entity
        expose :id, documentation: {
          type: String, required: true, defaultValue: "A",
          desc: "Short ID"
        }
        expose :name, documentation: {
          type: String, required: true, defaultValue: "Order of the Twin Adder",
          desc: "Name"
        }
        expose :alt, documentation: {
          type: String, required: true, defaultValue: "Adders",
          desc: "Shorter, colloquial version"
        }
        expose :tag, documentation: {
          type: String, required: true, defaultValue: "Serpent",
          desc: "Short name, used in ranks"
        }
        
        expose :members, documentation: {
          type: Integer, required: true, defaultValue: 9001,
          desc: "Total known members"
        }
        
        def characters
          ::Character.where(:grand_company => object[:id])
        end
        
        def members
          characters.count
        end
      end
    end
  end
end
