class RemoveSatisfactoryRangeFromParameter < ActiveRecord::Migration[7.0]
  def change
    remove_columns :parameters, :min_satisfactory, :max_satisfactory
  end
end
