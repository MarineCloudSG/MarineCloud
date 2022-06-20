class VesselMailer < ApplicationMailer
  def data_import_reminder_email
    @vessel = params[:vessel]
    @url = "/vessels/#{@vessel.id}"
    mail(to: vessel_emails, subject: "Reminder // Boiler and Cooling water analysis data submission")
  end

  def new_comment_email
    @vessel = params[:vessel]
    @message = params[:message]
    mail(to: vessel_emails, subject: "New comment")
  end

  private

  def vessel_emails
    [@vessel.user.email, @vessel.email].uniq
  end
end
