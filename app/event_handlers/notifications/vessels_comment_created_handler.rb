module Notifications
  class VesselsCommentCreatedHandler < PubSub::DomainEventHandler
    def call
      VesselMailer
        .with(vessel: vessel, message: message)
        .new_comment_email
        .deliver_later
    end

    private

    def comment_id
      event_data.comment_id
    end

    def message
      event_data.message
    end

    def vessel
      Vessel.find(vessel_id)
    end

    def vessel_id
      event_data.vessel_id
    end
  end
end
