module API
  module V1
    class Characters < Grape::API
      version 'v1'
      
      resource :characters do
        desc "Return a list of characters" do
          success API::V1::Entities::Character
        end
        get do
          characters = Character.where(:name.ne => nil).order(:id => 1).limit(20)
          present characters, with: API::V1::Entities::Character
        end
        
        desc "Returns a specific character" do
          success API::V1::Entities::Character
          failure [
            [404, "The character does not exist", API::V1::Entities::Error],
          ]
        end
        params do
          requires :id, type: Integer, desc: "Lodestone ID"
        end
        get ':id' do
          present Character.find(params[:id]), with: API::V1::Entities::Character
        end
      end
    end
  end
end
