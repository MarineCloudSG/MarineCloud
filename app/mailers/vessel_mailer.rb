class VesselMailer < ApplicationMailer
  def data_import_reminder_email
    @vessel = params[:vessel]
    @url = "/vessels/#{@vessel.id}"
    mail(to: @vessel.user.email, subject: "Reminder // Boiler and Cooling water analysis data submission")
  end
end
