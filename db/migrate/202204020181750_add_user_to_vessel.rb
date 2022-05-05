class AddUserToVessel < ActiveRecord::Migration[7.0]
  def change
    add_reference :vessels, :user, null: true, foreign_key: true
  end
end
