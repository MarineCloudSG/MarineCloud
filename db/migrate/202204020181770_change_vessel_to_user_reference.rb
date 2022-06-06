# frozen_string_literal: true

class ChangeVesselToUserReference < ActiveRecord::Migration[7.0]
  def change
    User.includes(:vessels).each do |user|
      next unless user.vessels.count.positive?

      user.vessels[1..user.vessels.count].each do |vessel|
        vessel.user = nil
        vessel.save!
      end
    end
    remove_index :vessels, :user_id
    add_index :vessels, :user_id, unique: true
  end
end
