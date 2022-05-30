class ChangeVesselCommentsYearMonthToDate < ActiveRecord::Migration[7.0]
  def change
    add_column :vessel_comments, :assigned_date, :date, default: -> { 'CURRENT_TIMESTAMP' }, index: true, null: true
    VesselComment.all.each do |comment|
      comment.assigned_date = Date.new(comment.year, comment.month, 1)
    end
    remove_column :vessel_comments, :year, :integer
    remove_column :vessel_comments, :month, :integer
    change_column_null :vessel_comments, :assigned_date, false
  end
end
