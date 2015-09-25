module API
  class Root < Grape::API
    content_type :json, 'application/json'
    default_format :json
    
    # rescue_from :all
    rescue_from Mongoid::Errors::DocumentNotFound do |e|
      error!({ error: e.problem }, 404)
    end
    
    mount API::V1::Root
    
    add_swagger_documentation \
      :api_version => 'v1',
      :base_path => '/api',
      :hide_documentation_path => true,
      :models => [
        API::V1::Entities::Character
      ]
  end
end
