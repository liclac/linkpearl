class ImportCharactersJob < ActiveJob::Base
  queue_as :default

  def perform(first_id = nil, batch_size = 500)
    first_id = first_id || Character.select(:id).where('name IS NOT NULL').order(:id).last.try(:id) || 1
    
    last_id = first_id + batch_size
    (first_id...last_id).each do |id|
      SyncCharacterJob.perform_later(id)
    end
  end
end
