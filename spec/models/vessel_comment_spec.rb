require 'rails_helper'

RSpec.describe VesselComment, type: :model do
  describe 'after_create' do
    xit 'emits vessels__comment_created' do
      user = create :user
      vessel = create :vessel, name: 'The Two'
      expect { VesselComment.create!(user: user, vessel: vessel, message: 'New comment') }
        .to broadcast(:vessels__comment_created,
                      comment_id: fetch_next_id_for(VesselComment),
                      vessel_id: vessel.id,
                      message_text: 'New comment',
                      event_uid: anything)
    end
  end
end
