class VesselCommentsController < BaseController
  def create
    comment = vessel.comments.build(comment_params)
    comment.user = current_user
    comment.save!
    redirect_to vessel, notice: 'Comment was successfully published'
  end

  private

  def vessel
    Vessel.find(params.fetch(:vessel_id))
  end

  def comment_params
    params.require(:vessel_comment).permit(:message, :assigned_date)
  end
end
