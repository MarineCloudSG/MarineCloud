class AddOverrangeUnderrangeToParameters < ActiveRecord::Migration[7.0]
  def change
    add_column :parameters, :overrange, :float
    add_column :parameters, :underrange, :float
  end
end
