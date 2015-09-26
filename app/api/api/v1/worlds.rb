module API
  module V1
    class Worlds < Grape::API
      include Grape::Kaminari
      version 'v1'
      
      resource :worlds do
        desc "List all worlds" do
          success API::V1::Entities::World
        end
        get do
          worlds = World.all.order(:name => 1)
          present :worlds, worlds, with: API::V1::Entities::World
        end
        
        desc "Show a specific world" do
          success API::V1::Entities::World
          failure [
            [404, "The world does not exist", API::V1::Entities::Error],
          ]
        end
        params do
          requires :world, type: String, desc: "World name"
        end
        get ':world' do
          world = World.find_by(name: params[:world].capitalize)
          present :world, world, with: API::V1::Entities::World
        end
      end
    end
  end
end
