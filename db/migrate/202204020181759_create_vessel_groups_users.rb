class CreateVesselGroupsUsers < ActiveRecord::Migration[7.0]
  def change
    create_join_table :vessel_groups, :users
  end
end
