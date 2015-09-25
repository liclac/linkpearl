module API
  class Root < Grape::API
    content_type :json, 'application/json'
    default_format :json
    
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
