class VesselMailer < ApplicationMailer
  def data_import_reminder_email
    @vessel = params[:vessel]
    @url = "/vessels/#{@vessel.id}"
    mail(to: @vessel.user.email, subject: "#{@vessel.name} data import reminder")
  end
end
