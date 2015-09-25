module API
  module V1
    module Entities
      class Character < Grape::Entity
        class Level < Grape::Entity
          expose :cls, documentation: {
            type: String, required: true, defaultValue: "Gladiator",
            desc: "Name of the class"
          }
          expose :level, documentation: {
            type: Integer, required: true, defaultValue: 43,
            desc: "Current level"
          }
          expose :exp, documentation: {
            type: Integer, required: true, defaultValue: 123456789,
            desc: "Total exp collected"
          }
          expose :need, documentation: {
            type: Integer, required: true, defaultValue: 4321,
            desc: "Exp until next level"
          }
          
          expose :updated_at, documentation: {
            type: DateTime, required: true, defaultValue: DateTime.now,
            desc: "Last updated at"
          }
        end
        
        class StatSet < Grape::Entity
          expose :str, documentation: {
            type: Integer, required: true, defaultValue: 40,
            desc: "Strength"
          }
          expose :dex, documentation: {
            type: Integer, required: true, defaultValue: 40,
            desc: "Dexterity"
          }
          expose :vit, documentation: {
            type: Integer, required: true, defaultValue: 40,
            desc: "Vitality"
          }
          expose :int, documentation: {
            type: Integer, required: true, defaultValue: 40,
            desc: "Intelligence"
          }
          expose :mnd, documentation: {
            type: Integer, required: true, defaultValue: 40,
            desc: "Mind"
          }
          expose :pie, documentation: {
            type: Integer, required: true, defaultValue: 40,
            desc: "Piety"
          }
          
          expose :acc, documentation: {
            type: Integer, required: true, defaultValue: 40,
            desc: "Accuracy"
          }
          expose :crt, documentation: {
            type: Integer, required: true, defaultValue: 40,
            desc: "Critical Hit Rate"
          }
          expose :det, documentation: {
            type: Integer, required: true, defaultValue: 40,
            desc: "Determination"
          }
          expose :par, documentation: {
            type: Integer, required: true, defaultValue: 40,
            desc: "Parry"
          }
          expose :sks, documentation: {
            type: Integer, required: true, defaultValue: 40,
            desc: "Skill Speed"
          }
          expose :sps, documentation: {
            type: Integer, required: true, defaultValue: 40,
            desc: "Spell Speed"
          }
          
          expose :updated_at, documentation: {
            type: DateTime, required: true, defaultValue: DateTime.now,
            desc: "Last updated at"
          }
        end
        
        expose :id, documentation: {
          type: Integer, required: true, defaultValue: 0,
          desc: "Lodestone ID"
        }
        expose :name, documentation: {
          type: String, required: true, defaultValue: "Yoshida Eee",
          desc: "The character's name"
        }
        expose :title_s, as: :title, documentation: {
          type: String, required: false, defaultValue: "The Heart of the Party",
          desc: "Title, if any"
        }
        expose :world_s, as: :world, documentation: {
          type: String, required: false, defaultValue: "Chocobo",
          desc: "World"
        }
        
        expose :stats, using: API::V1::Entities::Character::StatSet, documentation: {
          required: true, desc: "Current attributes"
        }
        
        expose :levels, using: API::V1::Entities::Character::Level, documentation: {
          required: true, desc: "Levels of all classes"
        }
        
        expose :created_at, documentation: {
          type: DateTime, required: true, defaultValue: DateTime.now,
          desc: "First imported at"
        }
        expose :updated_at, documentation: {
          type: DateTime, required: true, defaultValue: DateTime.now,
          desc: "Last updated at"
        }
      end
    end
  end
end
