class AddSatisfactoryRangeToParameter < ActiveRecord::Migration[7.0]
  def change
    add_column :parameters, :min_satisfactory, :float
    add_column :parameters, :max_satisfactory, :float
  end
end
