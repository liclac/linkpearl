module API
  module V1
    class GrandCompanies < Grape::API
      include Grape::Kaminari
      version 'v1'
      
      companies = [
        {
          :id => "M",
          :name => "Maelstrom",
          :alt => "Maelstrom",
          :tag => "Storm",
        },
        {
          :id => "F",
          :name => "The Immortal Flames",
          :alt => "Flames",
          :tag => "Flame"
        },
        {
          :id => "A",
          :name => "Order of the Twin Adder",
          :alt => "Adders",
          :tag => "Serpent"
        }
      ]
      
      resource :grand_companies do
        desc "List all grand companies" do
          success API::V1::Entities::GrandCompany
        end
        get do
          present :grand_companies, companies, with: API::V1::Entities::GrandCompany
        end
        
        desc "Show a specific grand company" do
          success API::V1::Entities::GrandCompany
          failure [
            [404, "The grand company does not exist", API::V1::Entities::Error],
          ]
        end
        params do
          requires :id, type: String, desc: "Title (exact)"
        end
        get ':id' do
          company = companies.detect { |c| c[:id] == params[:id] }
          error!({ error: "No grand company with that ID" }, 404) unless company
          present :grand_company, company, with: API::V1::Entities::GrandCompany
        end
      end
    end
  end
end
