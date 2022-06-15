require 'rails_helper'

RSpec.describe SendDataImportReminders do

  describe '.call' do
    it 'sends email to every vessel with no measurement last month' do
      vessel1 = create :vessel, user: (create :user)
      vessel2 = create :vessel, user: (create :user)
      vessel3 = create :vessel, user: (create :user)
      create :measurements_import, vessel: vessel2, created_at: DateTime.new(2020, 1, 23)
      mailer = VesselMailer.new
      mail = double
      allow(ActionMailer::Parameterized::Mailer).to receive(:new).and_return(mailer)
      allow(mailer).to receive(:data_import_reminder_email).and_return(mail)
      allow(mail).to receive(:deliver_later)

      travel_to DateTime.new(2020, 2, 10) do
        SendDataImportReminders.call
        expect(ActionMailer::Parameterized::Mailer).to have_received(:new).with(VesselMailer, { vessel: vessel1 })
        expect(ActionMailer::Parameterized::Mailer).to have_received(:new).with(VesselMailer, { vessel: vessel3 })
        expect(mail).to have_received(:deliver_later).exactly(2).times
      end
    end
  end
end
