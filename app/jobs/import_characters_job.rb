class ImportCharactersJob < ActiveJob::Base
  queue_as :default

  def perform(first_id = nil, batch_size = nil)
    first_id = first_id || Character.where(:name.ne => nil).desc(:_id).first.try(:id) || 1
    batch_size = batch_size || Character.where(:_id.gt => first_id).count >= 50 ? 150 : 500
    
    last_id = first_id + batch_size
    (first_id...last_id).each do |id|
      SyncCharacterJob.perform_later(id)
    end
  end
end
