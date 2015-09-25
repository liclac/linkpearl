module API
  module V1
    class Characters < Grape::API
      include Grape::Kaminari
      version 'v1'
      
      resource :characters do
        desc "Return a list of characters" do
          success API::V1::Entities::Character
        end
        paginate per_page: 20, max_per_page: 30
        get do
          characters = Character.where(:name.ne => nil).order(:id => 1)
          present :characters, paginate(characters), with: API::V1::Entities::Character
          present :total, characters.count()
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
          character = Character.where(:name.ne => nil).find(params[:id])
          present :character, character, with: API::V1::Entities::Character
        end
      end
    end
  end
end
