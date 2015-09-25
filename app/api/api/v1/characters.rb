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
      end
    end
  end
end
