class AddUniqueIndexToVesselName < ActiveRecord::Migration[7.0]
  def change
    add_index :vessels, :name, unique: true
  end
end
