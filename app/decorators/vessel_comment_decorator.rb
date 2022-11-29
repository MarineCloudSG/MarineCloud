class VesselCommentDecorator < ApplicationDecorator
  delegate_all

  def date
    created_at.to_date.to_s
  end

  def user_name
    user.email.split("@").first
  end
end