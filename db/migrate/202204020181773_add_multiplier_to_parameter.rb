class AddMultiplierToParameter < ActiveRecord::Migration[7.0]
  def change
    add_column :parameters, :photometer_value_multiplier, :decimal, default: 1
  end
end
