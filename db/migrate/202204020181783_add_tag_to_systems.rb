class AddTagToSystems < ActiveRecord::Migration[7.0]
  def change
    add_column :systems, :tag, :integer
  end
end
