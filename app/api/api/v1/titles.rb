module API
  module V1
    class Titles < Grape::API
      include Grape::Kaminari
      version 'v1'
      
      resource :titles do
        desc "List all titles" do
          success API::V1::Entities::Title
        end
        get do
          title = Title.all.order(:name => 1)
          present :title, title, with: API::V1::Entities::Title
        end
        
        desc "Show a specific world" do
          success API::V1::Entities::Title
          failure [
            [404, "The world does not exist", API::V1::Entities::Error],
          ]
        end
        params do
          requires :title, type: String, desc: "Title (exact)"
        end
        get ':title' do
          title = Title.find_by(name: params[:title].capitalize)
          present :title, title, with: API::V1::Entities::Title
        end
      end
    end
  end
end
