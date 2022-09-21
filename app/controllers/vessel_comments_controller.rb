class VesselCommentsController < BaseController
  def create
    comment = vessel.comments.build(comment_params)
    comment.user = current_user
    comment.save!
    redirect_to vessel_path(vessel, **view_params), notice: 'Comment was successfully published'
  end

  private

  def vessel
    Vessel.find(params.fetch(:vessel_id))
  end

  def comment_params
    params.require(:vessel_comment).permit(:message, :assigned_date)
  end

  def view_params
    JSON.parse request.params.fetch(:vessel_comment).fetch(:current_query)
  end
end
