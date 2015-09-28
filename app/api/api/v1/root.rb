module API
  module V1
    class Root < Grape::API
      mount API::V1::Characters
      mount API::V1::GrandCompanies
      mount API::V1::Worlds
      mount API::V1::Titles
    end
  end
end
