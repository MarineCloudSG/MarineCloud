class SendDataImportReminders < Patterns::Service
  def call
    vessels_to_remind.each do |vessel|
      VesselMailer.with(vessel: vessel).data_import_reminder_email.deliver
    end
  end

  private

  def vessels_to_remind
    Vessel.where.not(user_id: nil).select { |vessel| lacking_last_month_data?(vessel) }
  end

  def lacking_last_month_data?(vessel)
    vessel.last_data_upload.nil? || vessel.last_data_upload < (Date.today - 1.month).beginning_of_month
  end
end
