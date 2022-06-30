require 'rails_helper'

module Notifications
  RSpec.describe VesselsCommentCreatedHandler do
    describe '#call!' do
      it 'sends an email' do
        vessel = create :vessel, name: 'The One'
        comment = create :vessel_comment, message: 'Hello there!', vessel: vessel
        event_data = event_data_for(
          :vessels__comment_created,
          comment_id: comment.id,
          vessel_id: vessel.id,
          message_text: comment.message,
          vessel_name: comment.vessel.name)
        mailer = VesselMailer.new
        mail = double
        allow(ActionMailer::Parameterized::Mailer).to receive(:new).and_return(mailer)
        allow(mailer).to receive(:new_comment_email).and_return(mail)
        allow(mail).to receive(:deliver_later)

        VesselsCommentCreatedHandler.new(event_data).call!

        expect(ActionMailer::Parameterized::Mailer)
          .to have_received(:new)
          .with(VesselMailer, { vessel: vessel, message_text: 'Hello there!' })
        expect(mail).to have_received(:deliver_later)
      end
    end
  end
end
