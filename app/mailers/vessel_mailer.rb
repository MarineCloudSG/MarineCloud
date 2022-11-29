class VesselMailer < ApplicationMailer
  def data_import_reminder_email
    @vessel = params[:vessel]
    @url = "/vessels/#{@vessel.id}"
    mail(to: vessel_emails, subject: "Reminder // Boiler and Cooling water analysis data submission")
  end

  def new_comment_email
    @vessel = params[:vessel]
    @message_text = params[:message_text]
    mail(to: (vessel_emails + commenters_emails + admin_emails).uniq, subject: "New comment")
  end

  private

  def vessel_emails
    [@vessel.user.email, @vessel.email].uniq
  end

  def commenters_emails
    @vessel.comments.joins(:user).distinct.pluck('users.email')
  end

  def admin_emails
    AdminUser.all.pluck(&:email)
  end
end
