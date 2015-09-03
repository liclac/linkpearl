USER_AGENT = 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'

class SyncCharacterJob < ActiveJob::Base
  queue_as :default

  def perform(id)
    conn = Faraday.new(:url => 'http://na.finalfantasyxiv.com/lodestone') do |conn|
      conn.response :raise_error
      # conn.response :logger
      conn.adapter Faraday.default_adapter
    end
    conn.headers['User-Agent'] = USER_AGENT
    
    res = conn.get "character/#{id}/"
    char = Character.find_or_initialize_by(id: id)
    char.parse_html(res.body)
    char.save!
  end
end
