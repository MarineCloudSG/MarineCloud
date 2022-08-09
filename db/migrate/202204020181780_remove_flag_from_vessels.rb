class RemoveFlagFromVessels < ActiveRecord::Migration[7.0]
  def change
    remove_column :vessels, :flag
  end
end
