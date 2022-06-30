class VesselComment < ApplicationRecord
  include PubSub::Emit

  belongs_to :user
  belongs_to :vessel

  after_create do
    emit(:vessels__comment_created, {
           comment_id: id,
           vessel_id: vessel.id,
           message_text: message
         })
  end
end
