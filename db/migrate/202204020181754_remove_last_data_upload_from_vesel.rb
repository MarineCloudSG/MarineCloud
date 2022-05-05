class RemoveLastDataUploadFromVesel < ActiveRecord::Migration[7.0]
  def change
    remove_column :vessels, :last_data_upload, :datetime
  end
end
